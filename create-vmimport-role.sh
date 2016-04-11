#!/usr/bin/env bash

# Create 'vmimport' role

aws iam create-role --role-name vmimport --assume-role-policy-document file://trust-policy.json
