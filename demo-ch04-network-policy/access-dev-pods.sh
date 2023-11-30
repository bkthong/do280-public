#!/bin/bash
#
#Script to test access 
# - ingress (external traffic in) 
# - internal cluster communication from {production,qa}-project to dev-project pods

DEV_ROUTE="`oc get route webserver -n dev-project  -o jsonpath='{.spec.host}'`"

# Access the webserver dev via route (external traffic)
echo
echo "-----------------------------------------------------------"
echo
echo "**** external --> route -->  dev-project pod ****"
curl --silent --connect-timeout 3  $DEV_ROUTE
echo
echo "In a SNO cluster using HostNetwork for endpoint publishing stratey,"
echo "this will always work."
echo 
echo "Pods with host networking enabled are unaffected by network policy rules."

# Access the webserver dev from production pod
echo
echo "-----------------------------------------------------------"
echo
echo "**** production-project pod --> dev-project pod ****"
oc exec -n production-project deploy/webserver  -- \
curl --silent --connect-timeout 3  webserver.dev-project.svc.cluster.local:8080

echo
echo "-----------------------------------------------------------"
echo
echo "**** qa-project pod --> dev-project pod ****"
oc exec -n qa-project deploy/webserver  -- \
curl --silent --connect-timeout 3  webserver.dev-project.svc.cluster.local:8080
echo
echo
