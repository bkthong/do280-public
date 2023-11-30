## WARNING
Be careful not to mix up 
- network.operator  --> This is the one to edit

    vs
    
- network.config

## Notes
- If you put the net-attach-def in a normal project only
  pods in that project can reference it
- Easiest way to share the net-attach-def with other projects is to
  create it in the "default" namespace
- I chose not to declare the IP in the net-attach-def, but at the 
  pod annotation
- Have a terminal open for lab@utility and another terminal for debug pod for easy
  demo 

## Pre-requisites
- Have admin privileges
- Have a project ready to create the test1 and 2 pods


## Create the net-attach-def (using network.operator CR method)

```
oc get network.operator/cluster -o yaml > network.operator.yaml
vim network.operator.yaml
--> Copy the additionalNetworks section from the additional-network.yaml
    file into this file

oc apply -f network.operator.yaml
oc get net-attach-def -n default


# Reverse changes so that we can use method 2
vim network.operator.yaml
--> remove the additionalNetworks section
oc apply -f network.operator.yaml
oc get net-attach-def -n default
--> After a while the Network operator removes the net-attach-def
```

## Create the net-attach-def directly
```
oc apply -f network-attachment-def.yaml
--> Take note of the full name for net-attach-def as you need it for oc gets
--> else use net-atttach-def short name
   
oc get net-attach-def -n default
```


## Create a pod that uses the new network

```
oc apply -f test1-pod.yaml
oc exec test1 -- ip -br a show
--> net1 has 192.168.51.10


ssh lab@utility
(utility)) $ curl 192.168.51.10:8080 
		--> can see the simple website 1.1

(utility)) $ ip a show | grep ens4
		--> ens4 is no longer visible
		--> brought into the pods network namespace
(utility)) $ exit

oc apply -f test2-pod.yaml
--> remains pending as test1 has already used ens4
--> oc get events shows relevant message
		error adding containers ... link not found

oc delete pod test1
	--> test2 pod now can start properly since test1 is deleted and
            releases ens4

oc exec test2 -- ip -br a show
--> net1 for test2 pod now has the IP 192.168.51.10

ssh lab@utility
(utility)) $ curl 192.168.51.10:8080 
		--> can see the simeplw website 1.2

On  debug pod on master01:
(debug pod)) $ ip a show | grep ens4
		--> ens4 is no longer visible
		--> brought into the pods network namespace


oc delete pod test2

(utility)) $ curl 192.168.51.10:8080 
		--> can NO LONGER access any website

On  debug pod on master01:
(debug pod)) $ ip a show | grep ens4
		--> ens4 is visible again.

```


## Cleanup

```
oc delete net-attach-def --all -n default
```
