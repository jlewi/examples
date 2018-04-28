local params = import "../../components/params.libsonnet";
params + {
  components +: {
    // Insert component parameter overrides here. Ex:
    // guestbook +: {
    //   name: "guestbook-dev",
    //   replicas: params.global.replicas,
    // },
    "kubeflow-core" +: {
      jupyterHubAuthenticator: "iap",
    },
    tensorboard +: {
      logDir: "gs://kubecon-gh-demo/gh-t2t-out",      
    },
  },
}
