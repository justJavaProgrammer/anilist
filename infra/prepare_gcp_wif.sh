#!/bin/bash

GCP_PROJECT_ID="integral-zephyr-481413-k6"
GCP_PROJECT_NUMBER="761028433156"
GITLAB_PROJECT_ID="77386361"

gcloud iam workload-identity-pools create gitlab \
--location="global" \
--display-name="Gitlab Pool" \
--description="GitLab Pool for CI" \
--disabled

gcloud iam workload-identity-pools providers create-oidc "gitlab-runner-provider" \
 --location="global" \
 --workload-identity-pool="gitlab" \
 --display-name="Provider for GitLab CI" \
 --issuer-uri="https://gitlab.com" \
 --attribute-condition="attribute.project_id=='${GITLAB_PROJECT_ID}'" \
--attribute-mapping="google.subject=assertion.project_id + \"::\" + assertion.ref, \
    attribute.aud=assertion.aud, \
    attribute.ci_config_sha=assertion.ci_config_sha, \
    attribute.namespace_id=assertion.namespace_id, \
    attribute.namespace_path=assertion.namespace_path, \
    attribute.project_id=assertion.project_id, \
    attribute.project_path=assertion.project_path, \
    attribute.ref=assertion.ref, \
    attribute.ref_protected=assertion.ref_protected ? \"true\" : \"false\", \
    attribute.ref_type=assertion.ref_type, \
    attribute.sha=assertion.sha, \
    attribute.sub=assertion.sub"

gcloud iam service-accounts create gitlab-sa \
 --description="A service account for use in a Gitlab workflow" \
 --display-name="GitLab service account."

gcloud iam service-accounts add-iam-policy-binding gitlab-sa@${GCP_PROJECT_ID}.iam.gserviceaccount.com \
    --role=roles/iam.workloadIdentityUser \
    --member="principalSet://iam.googleapis.com/projects/${GCP_PROJECT_NUMBER}/locations/global/workloadIdentityPools/gitlab/*"

