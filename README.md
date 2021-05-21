# vltischool-2021

Infrastructure As Code side

Prerequisite:
 * the `terraform` command
 * a working image ( see `../packer` directory )
 * a valid token with `api` rights https://gricad-gitlab.univ-grenoble-alpes.fr/-/profile/personal_access_tokens store in API_TOKEN env var for next commands

Init step (to define the backend on gitlab ):
'''
terraform init \
        -backend-config="address=https://gricad-gitlab.univ-grenoble-alpes.fr/api/v4/projects/$project_id/terraform/state/$OS_PROJECT_NAME" \
        -backend-config="lock_address=https://gricad-gitlab.univ-grenoble-alpes.fr/api/v4/projects/$project_id/terraform/state/$OS_PROJECT_NAME/lock" \
        -backend-config="unlock_address=https://gricad-gitlab.univ-grenoble-alpes.fr/api/v4/projects/$project_id/terraform/state/$OS_PROJECT_NAME/lock" \
        -backend-config="username=$GITLAB_API_USERNAME" \
        -backend-config="password=$GITLAB_API_PASSWORD" \
        -backend-config="lock_method=POST" \
        -backend-config="unlock_method=DELETE" \
        -backend-config="retry_wait_min=5"
'''

Next command should be OK using env var defined by the `source vltischool-openrc.sh`:
'''
export project_id=11584
terraform init \
        -backend-config="address=https://gricad-gitlab.univ-grenoble-alpes.fr/api/v4/projects/$project_id/terraform/state/$OS_PROJECT_NAME" \
        -backend-config="lock_address=https://gricad-gitlab.univ-grenoble-alpes.fr/api/v4/projects/$project_id/terraform/state/$OS_PROJECT_NAME/lock" \
        -backend-config="unlock_address=https://gricad-gitlab.univ-grenoble-alpes.fr/api/v4/projects/$project_id/terraform/state/$OS_PROJECT_NAME/lock" \
        -backend-config="username=$OS_USERNAME" \
        -backend-config="password=$API_TOKEN" \
        -backend-config="lock_method=POST" \
        -backend-config="unlock_method=DELETE" \
        -backend-config="retry_wait_min=5"
'''


