# test-cloudbuild


Useful commands:
  gcloud services enable sourcerepo.googleapis.com
  gcloud services enable compute.googleapis.com
  gcloud services enable servicemanagement.googleapis.com
  gcloud services enable storage-api.googleapis.com

  CLOUD_BUILD_ACCOUNT=$(gcloud projects get-iam-policy $PROJECT --filter="(bindings.role:roles/cloudbuild.builds.builder)"  --flatten="bindings[].members" --format="value(bindings.members[])")


#gcloud projects add-iam-policy-binding $PROJECT \
#  --member $CLOUD_BUILD_ACCOUNT \
#  --role roles/editor

