For demoing kustomize. 

When showing the overlays/prod need to have the prod-db project created
Likewise for overlays.dev, the dev-db project must exist

Secrets generated are kept in updates. Ie you get new secret and the old one
is still there. During oc delete -k, only the latest scret is deleted.
The old ones are not cleaned up. Manual cleanup required

