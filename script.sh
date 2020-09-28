#!/bin/bash
#requires jq -> http://stedolan.github.io/jq/

cd "/root/Bkps/repositories"

user="user"
token="token"
organization="org"

repo_list=$(curl https://api.github.com/orgs/$organization/repos?type=private\&per_page=100 -u ${user}:${token}  | jq .[].ssh_url | sed -e 's/^"//'  -e 's/"$//' | cut -d "/" -f 2 | cut -d "." -f 1)

for repo in $repo_list
do

  git clone "https://github.com/"$organization"/"$repo

  tar -czf $repo.tar.gz $repo --remove-files

done
