#!/usr/bin/env bash
# Run terraform in infra/ with the state backend on R2.
#
# Usage: scripts/terraform.sh <terraform args...>
#   scripts/terraform.sh init
#   scripts/terraform.sh plan -out=plan.tfout
#   scripts/terraform.sh apply plan.tfout
#
# Needs in the environment, or in infra/.env.local which is sourced if present:
#   R2_ACCESS_KEY_ID, R2_SECRET_ACCESS_KEY    an R2 token's S3 keys, for the state
#   CLOUDFLARE_ACCOUNT_ID                     the R2 endpoint
#   TF_VAR_cloudflare_api_token               the cloudflare provider
#
# The same shape as lonkar-org/lonkar.org's scripts/terraform.sh: the backend
# gets its keys and endpoint as -backend-config flags rather than AWS_*
# variables, so it never picks up whatever AWS credentials a shell carries.
# Terraform keeps those values in infra/.terraform/ and in saved plan files;
# both are gitignored. This repository is public, so nothing here may print
# them.
set -euo pipefail

cd "$(dirname "$0")/../infra"

if [[ -f .env.local ]]; then
  # shellcheck disable=SC1091
  source .env.local
fi

: "${R2_ACCESS_KEY_ID:?R2_ACCESS_KEY_ID is not set}"
: "${R2_SECRET_ACCESS_KEY:?R2_SECRET_ACCESS_KEY is not set}"
: "${CLOUDFLARE_ACCOUNT_ID:?CLOUDFLARE_ACCOUNT_ID is not set}"

if [[ "${1:-}" == "init" ]]; then
  shift
  exec terraform init \
    -backend-config=backend.config \
    -backend-config="endpoints={s3=\"https://${CLOUDFLARE_ACCOUNT_ID}.r2.cloudflarestorage.com\"}" \
    -backend-config="access_key=${R2_ACCESS_KEY_ID}" \
    -backend-config="secret_key=${R2_SECRET_ACCESS_KEY}" \
    "$@"
fi

exec terraform "$@"
