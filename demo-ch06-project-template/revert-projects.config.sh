oc apply -f projects.config-revert.yaml
oc wait --for=condition=Progressing --timeout=60s co/openshift-apiserver
oc rollout status deployment/apiserver -n openshift-apiserver
