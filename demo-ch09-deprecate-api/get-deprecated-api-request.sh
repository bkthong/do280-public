#!/bin/bash
#
oc get apirequestcounts | awk '{if(NF==4){print $0}}'
