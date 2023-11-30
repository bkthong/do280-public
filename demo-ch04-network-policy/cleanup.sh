#!/bin/bash
#
#Script to delete the three projects

oc delete project production-project
oc delete project qa-project
oc delete project dev-project
