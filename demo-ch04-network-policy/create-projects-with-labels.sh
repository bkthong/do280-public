oc new-project dev-project
oc label namespace dev-project env=dev
oc apply -k webserver/overlays/dev

oc new-project qa-project
oc label namespace qa-project env=qa
oc apply -k webserver/overlays/qa

oc new-project production-project
oc label namespace production-project env=prod
oc apply -k webserver/overlays/production
