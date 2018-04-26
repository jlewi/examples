local params = import "../../components/params.libsonnet";
params + {
  components +: {
    // Insert component parameter overrides here. Ex:
    // guestbook +: {
    //   name: "guestbook-dev",
    //   replicas: params.global.replicas,
    // },
    "iap-ingress" +: {
      hostname: "kubecon-gh1.kubeflow.org",
      ipName: "static-ip",
    },
    "kubeflow-core" +: {
      jupyterHubAuthenticator: "iap",
    },
  },
}
