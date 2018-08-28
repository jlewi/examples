{
  global: {},
  components: {
    "t2t-job": {
      jobType: "trainer",
      numWorker: 1,
      numPs: 0,
      numWorkerGpu: 0,
      numPsGpu: 0,
      train_steps: 100,
      eval_steps: 10,
      image: "gcr.io/kubeflow-dev/code-search:v20180817-732333a",
      imageGpu: "gcr.io/kubeflow-dev/code-search:v20180817-732333a-gpu",
      imagePullSecrets: [],
      dataDir: "null",
      outputDir: "null",
      model: "null",
      hparams_set: "null",
    },
    "t2t-code-search": {
      name: "t2t-code-search",
      workingDir: "gs://example/prefix",
      problem: "cs_github_function_docstring",
      model: "cs_similarity_transformer",
      hparams_set: "transformer_tiny",
    },
    "t2t-code-search-datagen": {
      jobType: "datagen",
      name: "t2t-code-search-datagen",
      problem: $.components["t2t-code-search"].problem,
      dataDir: $.components["t2t-code-search"].workingDir + "/data",
    },
    "t2t-code-search-trainer": {
      numGpus: 1,
      numWorkerGpu: 1,
      problem: "cs_github_function_docstring",
      name: "code-search-train-0827-base",
      jobType: "trainer",
      numWorker: 1,
      image: "gcr.io/kubeflow-dev/code-search:v20180817-732333a",
      imageGpu: "gcr.io/kubeflow-dev/code-search:v20180817-732333a-gpu",
      dataDir: "gs://kubeflow-examples/t2t-code-search/notebook-demo/data",
      outputDir: "gs://cloud-ml-dev_jlewi_cs/mode/2018_0827_base_single_gpu",
      train_steps: 2000000,
      eval_steps: 10000,
      model: "cs_similarity_transformer",
      hparams_set: "transformer_base_single_gpu",
    },
    "t2t-code-search-exporter": {
      jobType: "exporter",
      name: "t2t-code-search-exporter",
      problem: $.components["t2t-code-search"].problem,
      dataDir: $.components["t2t-code-search"].workingDir + "/data",
      outputDir: $.components["t2t-code-search"].workingDir + "/output",
      model: $.components["t2t-code-search"].model,
      hparams_set: $.components["t2t-code-search"].hparams_set,
    },
    "t2t-code-search-serving": {
      name: "t2t-code-search",
      modelName: "t2t-code-search",
      modelPath: $.components["t2t-code-search"].workingDir + "/output/export/Servo",
      modelServerImage: "gcr.io/kubeflow-images-public/tensorflow-serving-1.8:latest",
      cloud: "gcp",
      gcpCredentialSecretName: "user-gcp-sa",
    },
    nmslib: {
      replicas: 1,
      image: "gcr.io/kubeflow-dev/code-search-ui:v20180817-0d4a60d",
      problem: "null",
      dataDir: "null",
      lookupFile: "null",
      indexFile: "null",
      servingUrl: "null",
    },
    "search-index-creator": {
      name: "search-index-creator",
      dataDir: $.components["t2t-code-search"].workingDir + "/data",
      lookupFile: $.components["t2t-code-search"].workingDir + "/code_search_index.csv",
      indexFile: $.components["t2t-code-search"].workingDir + "/code_search_index.nmslib",
    },
    "search-index-server": {
      name: "search-index-server",
      problem: $.components["t2t-code-search"].problem,
      dataDir: $.components["t2t-code-search"].workingDir + "/data",
      lookupFile: $.components["t2t-code-search"].workingDir + "/code_search_index.csv",
      indexFile: $.components["t2t-code-search"].workingDir + "/code_search_index.nmslib",
      servingUrl: "http://t2t-code-search.kubeflow:9001/v1/models/t2t-code-search:predict",
    },
    tensorboard: {
      image: "tensorflow/tensorflow:1.8.0",
      logDir: "gs://cloud-ml-dev_jlewi_cs/mode/2018_0825/",
      name: "tensorboard",
    },
  },
}
