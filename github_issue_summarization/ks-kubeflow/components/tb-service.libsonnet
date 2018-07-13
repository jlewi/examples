{
	tbService(name, env):: {
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
	          "service: " + name + "-tb." + env.namespace,
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
	},
}