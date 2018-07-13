local env = std.extVar("__ksonnet/environments");
local params = std.extVar("__ksonnet/params").components.tensorboard;
local k = import "k.libsonnet";

// This is a weird hack to deal with the ksonnet bug
// where if we don't import the service from a libsonnet file the Ambassador mapping
// won't be parsed correctly
// https://github.com/ksonnet/ksonnet/issues/670
local tbService = import "tb-service.libsonnet";

local name = params.name;
local namespace = env.namespace;
local service = tbService.tbService(name, env);

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
