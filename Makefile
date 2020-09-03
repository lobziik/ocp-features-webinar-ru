NAMESPACE = "awesome-app"
WEBHOOK_SECRET_VALUE ?= ''

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-app:  ### build app locally
	go build -o ./build/awsome_app ./app/hello.go

test-app: ### run tests for app
	go test ./app

deployment-config-dry-run: ### Dry run oc process with DeploymentConfig template
	oc process -f ./ocp_template/my_awsome_app_deployment_config.yml -p WEBHOOK_SECRET_VALUE=foo

deployment-config-apply: ### Apply template with DeploymentConfig to your cluster
	oc process -f ./ocp_template/builds_and_deploymentconfigs/my_awsome_app_template.yml \
 	   -p WEBHOOK_SECRET_VALUE=$(WEBHOOK_SECRET_VALUE) | oc apply -f - -n $(NAMESPACE)

jenkins-master: ### Spin up ephemeral jenkins master
	oc new-app jenkins-ephemeral -n $(NAMESPACE)

jenkins-config-apply: ### Apply template with example jenkins pipeline build to your cluster, jenkins master should be spinned up
	oc process -f ocp_templates/jenkins_pipeline_build/my_awsome_app_jenkins_pipeline_template.yml \
 	   -p WEBHOOK_SECRET_VALUE=$(WEBHOOK_SECRET_VALUE) -p NAMESPACE=$(NAMESPACE) | oc apply -f - -n $(NAMESPACE)

tekton-helm-chart-install: ### Install helmchart with app and tekton pipeline
	helm install app-with-pipeline ./helm_charts/app_with_pipeline -n $(NAMESPACE)

tekton-helm-chart-upgrade: ### Upgrade helmchart with app and tekton pipeline
	helm upgrade app-with-pipeline ./helm_charts/app_with_pipeline -n $(NAMESPACE)

s2i-create-app: ### Create all resources using oc new-app manually service creation will be needed
	oc new-app golang~https://github.com/lobziik/ocp-features-webinar-ru.git