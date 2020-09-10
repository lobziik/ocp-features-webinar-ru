NAMESPACE = "awesome-app"
WEBHOOK_SECRET_VALUE ?= ''

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-app:  ### build app locally
	go build -o ./build/awsome_app hello.go

deployment-config-dry-run: ### Dry run oc process with DeploymentConfig template
	oc process -f ./my_awsome_app_template.yml

deployment-config-apply: ### Apply template with DeploymentConfig to your cluster
	oc process -f ./ocp_template/my_awsome_app_deployment_config.yml -p WEBHOOK_SECRET_VALUE=$(WEBHOOK_SECRET_VALUE) | oc apply -f - -n $(NAMESPACE)

deployment-dry-run: ### Dry run oc process with Deployment template
	oc process -f ./my_awsome_app_deployment.yml

deployment-apply: ### Apply template with Deployment to your cluster
	oc process -f ./ocp_template/my_awsome_app_deployment.yml -p WEBHOOK_SECRET_VALUE=$(WEBHOOK_SECRET_VALUE) | oc apply -f - -n $(NAMESPACE)

s2i-create-app: ### Create all resources using oc new-app manually service creation will be needed
	oc new-app golang~https://github.com/lobziik/ocp-features-webinar-ru.git