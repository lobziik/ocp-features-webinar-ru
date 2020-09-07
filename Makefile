
build-app:
	go build -o ./build/awsome_app hello.go

dry-run:
	oc process -f ./my_awsome_app_template.yml

deploy-template:
	oc process -f ./ocp_template/my_awsome_app_template.yml | oc apply -f -

s2i-create-app:
	oc new-app golang~https://github.com/lobziik/ocp-features-webinar-ru.git