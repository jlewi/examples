{
  global: {
    // User-defined global parameters; accessible to all component and environments, Ex:
    // replicas: 4,
  },
  components: {
    // Component-level parameters, defined initially from 'ks prototype use ...'
    // Each object below should correspond to a component in the components/ directory
    "data-pvc": {
    },

    "kubeflow-core": {
      cloud: "null",
      disks: "null",
      jupyterHubAuthenticator: "null",
      jupyterHubImage: "gcr.io/kubeflow/jupyterhub-k8s:1.0.1",
      jupyterHubServiceType: "ClusterIP",
      jupyterNotebookPVCMount: "/home/jovyan/work",
      name: "kubeflow-core",
      namespace: "null",
      reportUsage: "true",
      tfAmbassadorServiceType: "ClusterIP",
      tfDefaultImage: "null",
      tfJobImage: "gcr.io/kubeflow-images-staging/tf_operator:v20180329-a7511ff",
      tfJobUiServiceType: "ClusterIP",
      usageId: "7cf1496f-7c67-4dc4-8ce5-1e28f3e03bcd",
    },
    seldon: {
      apifeImage: "seldonio/apife:0.1.5",
      apifeServiceType: "NodePort",
      engineImage: "seldonio/engine:0.1.5",
      name: "seldon",
      namespace: "null",
      operatorImage: "seldonio/cluster-manager:0.1.5",
      operatorJavaOpts: "null",
      operatorSpringOpts: "null",
      withApife: "false",
      withRbac: "true",
    },
    "issue-summarization-model-serving": {
      endpoint: "REST",
      image: "gcr.io/kubeflow-images-public/issue-summarization:0.1",
      name: "issue-summarization",
      namespace: "null",
      replicas: 2,
    },
    tensor2tensor: {
      namespace: "null",
    },
    tfjob: {
      namespace: "null",
    },
    ui: {
      namespace: "null",
    },
    "cert-manager": {
      acmeEmail: "jlewi@google.com",
      acmeUrl: "https://acme-v01.api.letsencrypt.org/directory",
      name: "cert-manager",
      namespace: "kubeflow",
    },
    "iap-ingress": {
      disableJwtChecking: "false",
      envoyImage: "gcr.io/kubeflow-images-staging/envoy:v20180309-0fb4886b463698702b6a08955045731903a18738",
      hostname: "null",
      ipName: "ipName",
      issuer: "letsencrypt-prod",
      name: "iap-ingress",
      namespace: "kubeflow",
      oauthSecretName: "kubeflow-oauth",
      secretName: "envoy-ingress-tls",
    },
  },
}
