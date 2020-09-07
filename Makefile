NAMESPACE = "awsm-app"
WEBHOOK_SECRET_VALUE ?= ''

build-app:
	go build -o ./build/awsome_app hello.go

dry-run:
	oc process -f ./my_awsome_app_template.yml

deploy-template:
	oc process -f ./ocp_template/my_awsome_app_deployment_config.yml -p WEBHOOK_SECRET_VALUE=$(WEBHOOK_SECRET_VALUE) | oc apply -f - -n $(NAMESPACE)

s2i-create-app:
	oc new-app golang~https://github.com/lobziik/ocp-features-webinar-ru.git