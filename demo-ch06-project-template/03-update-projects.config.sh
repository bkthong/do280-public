oc apply -f projects.config.yaml 
oc wait --for=condition=Progressing --timeout=60s co/openshift-apiserver
oc rollout status deployment/apiserver -n openshift-apiserver

echo Completed changes. Try creating to see whether the project template works. 
echo There should be resource quota in the new project after creation
