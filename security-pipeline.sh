#!/usr/bin/env bash
set -euo pipefail

echo "=== Stage 1: Terraform formatting ==="
if ! terraform fmt -check -recursive; then
  echo "FAIL: Terraform formatting check failed."
  exit 1
fi

echo "PASS: Terraform formatting check"

echo "=== Stage 2: Trivy IaC security scan ==="
docker run --rm \
  -v "$PWD:/work" \
  aquasec/trivy:latest \
  config --exit-code 1 --severity UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL /work

echo "PASS: Trivy IaC security scan"
echo "PIPELINE PASSED"
