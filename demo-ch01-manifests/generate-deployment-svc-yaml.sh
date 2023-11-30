#!/bin/bash
# Script using oc to generate a skeleton YAML for deployment
# As a strategy to easily get an initial manifest
# Not perfect as fields may need to be added

oc create deployment web --image=quay.io/bkthong/webserver-hello-ocp:1.1 \
--dry-run=client \
--save-config \
-o yaml \
>  deployment-web.yaml

oc create service clusterip web --tcp=8080:8080 \
--dry-run=client \
--save-config \
-o yaml \
> service-web.yaml
