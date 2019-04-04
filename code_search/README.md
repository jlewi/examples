# Code Search on Kubeflow

This demo implements End-to-End Code Search on Kubeflow.

# Warning: Running this example can be very expensive

This example uses large amounts of computation and cost several hundred dollars to run E2E on Cloud.

* You might want to consider [setting up billing alerts](https://cloud.google.com/billing/docs/how-to/budgets) on GCP
  to ensure you don't leave jobs running consuming large amounts of resources.

# Prerequisites

**NOTE**: If using the JupyterHub Spawner on a Kubeflow cluster, use the Docker image 
`gcr.io/kubeflow-images-public/kubeflow-codelab-notebook` which has baked all the pre-prequisites.

* `Kubeflow Latest`
  This notebook assumes a Kubeflow cluster is already deployed. See
  [Getting Started with Kubeflow](https://www.kubeflow.org/docs/started/getting-started/).

* `Python 2.7` (bundled with `pip`) 
  For this demo, we will use Python 2.7. This restriction is due to [Apache Beam](https://beam.apache.org/),
  which does not support Python 3 yet (See [BEAM-1251](https://issues.apache.org/jira/browse/BEAM-1251)).

* `Google Cloud SDK`
  This example will use tools from the [Google Cloud SDK](https://cloud.google.com/sdk/). The SDK 
  must be authenticated and authorized. See
  [Authentication Overview](https://cloud.google.com/docs/authentication/).
  
* `Ksonnet 0.12`
  We use [Ksonnet](https://ksonnet.io/) to write Kubernetes jobs in a declarative manner to be run
  on top of Kubeflow.

# Getting Started

To get started, follow the instructions below.

* These instructions are for Kubeflow **v0.5.0**

* Navigate to the landing page for Kubeflow at **http://${FQDN}**

  * Where ${FQDN} is the fully qualified domain name of your Kubebeflow cluster

* From the Kubeflow landing page navigate to Notebooks and spawn a notebook
  
* In the **Image** text field, enter [gcr.io/kubeflow-examples/kubeflow-codelab-notebook:v20190401-v0.2-183-ga1c0e69-dirty-89a5f3](gcr.io/kubeflow-examples/kubeflow-codelab-notebook:v20190401-v0.2-183-ga1c0e69-dirty-89a5f3).
  
  * This image contains all the pre-requisites needed for the demo.
  * The source is in [kubeflow/examples/codelab_image](https://github.com/kubeflow/examples/tree/master/codelab-image)
  * Use **namespace**, **kubeflow**

    * This is needed on GCP because only that namespace contains a GCP service account credential.

* Once spawned, you should be able to connect to the Jupyter UI

* Spawn a new Terminal and run
  ```
  $ git clone --branch=master --depth=1 https://github.com/kubeflow/examples
  ```
  This will create an examples folder. It is safe to close the terminal now.
  
* Navigate back to the Jupyter Notebooks UI and navigate to `examples/code_search`. Open
  the Jupyter notebook `code-search.ipynb` and follow it along.

# Acknowledgements

This project derives from [hamelsmu/code_search](https://github.com/hamelsmu/code_search).
