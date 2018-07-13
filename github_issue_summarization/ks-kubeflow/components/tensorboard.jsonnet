local env = std.extVar("__ksonnet/environments");
local params = std.extVar("__ksonnet/params").components.tensorboard;
local k = import "k.libsonnet";

local name = params.name;
local namespace = env.namespace;
local service = {
  apiVersion: "v1",
  kind: "Service",
  metadata: {
    name: name + "-tb",
    namespace: env.namespace,
    annotations: {
      "getambassador.io/config":
        std.join("\n", [
          "---",
          "apiVersion: ambassador/v0",
          "kind:  Mapping",
          "name: " + name + "_mapping",
          "prefix: /tensorboard/" + name + "/",
          "rewrite: /",
          "service: " + name + "-tb." + namespace,
        ]),
    },  //annotations
  },
  spec: {
    ports: [
      {
        name: "http",
        port: 80,
        targetPort: 80,
      },
    ],
    selector: {
      app: "tensorboard",
      "tb-job": name,
    },
  },
};

local deployment = {
  apiVersion: "apps/v1beta1",
  kind: "Deployment",
  metadata: {
    name: name + "-tb",
    namespace: env.namespace,
  },
  spec: {
    replicas: 1,
    template: {
      metadata: {
        labels: {
          app: "tensorboard",
          "tb-job": name,
        },
        name: name,
        namespace: namespace,
      },
      spec: {
        containers: [
          {
            command: [
              "/usr/local/bin/tensorboard",
              "--logdir=" + params.logDir,
              "--port=80",
            ],
            env: [
              {
                name: "GOOGLE_APPLICATION_CREDENTIALS",
                value: "/var/run/secrets/sa/user-gcp-sa.json",
              },
            ],
            image: params.image,
            name: "tensorboard",
            ports: [
              {
                containerPort: 80,
              },
            ],
            volumeMounts: [
             {
               mountPath: "/var/run/secrets/sa",
               name: "sa-key",
               readOnly: true,
             },
            ],
            // "livenessProbe": {
            //    "httpGet": {
            //      "path": "/",
            //      "port": 80
            //    },
            //    "initialDelaySeconds": 15,
            //    "periodSeconds": 3
            //  }
          },
        ],
        volumes: [
          {
            name: "sa-key",
            secret:{ 
              defaultMode: 420,
              secretName: "user-gcp-sa",
            },
          },
        ],
      },
    },
  },
};

std.prune(k.core.v1.list.new([service, deployment]))
