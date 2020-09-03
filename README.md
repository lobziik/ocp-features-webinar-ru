## Openshift Build, Deploy and Pipelines demo


### Prerequisites

Openshift CLI tools should be installed, [OKD](https://github.com/openshift/okd/releases) version is fine too

Helm should be installed for using chart with Tekton pipelines

### Usage
- Use `$ make` so see avalaible shortcuts


### Notes
- Intended to use with Openshift >4.4. Tested on 4.6 with Pipelines Operator v 1.1.1
- Openshift Pipelines Operator needed for performing tekton pipelines

### Contents
- `ocp_templates` - oc templates with demo deployment and deployment with jenkins pipeline build
- `helm_charts` - contains chart with app deployment and tekton pipeline
- `app` - app source code with "test suite"