local params = import "../../components/params.libsonnet";
params + {
  components +: {
    // Insert component parameter overrides here. Ex:
    // guestbook +: {
    //   name: "guestbook-dev",
    //   replicas: params.global.replicas,
    // },
    "iap-ingress" +: {
      hostname: "kubecon-booth.kubeflow.dev",
      ipName: "static-ip",
    },
    "kubeflow-core" +: {
      jupyterHubAuthenticator: "iap",
    },
    "tensor2tensor" +: {
      name: "gh-t2t-trainer-04292110",
      outputGCSPath: "gs://kubecon-booth-gh-demo/gh-t2t-out/04292110",
    },
  },
}
