#!/bin/bash
set -eux
TAG_NAME=${GITHUB_REF:10}
FILE_NAME=${TAG_NAME%-*}

# build pdf (change if necessary)
latexmk -pdfdvi $FILE_NAME.tex

# # create release
# res=`curl -H "Authorization: token $GITHUB_TOKEN" -X POST https://api.github.com/repos/$GITHUB_REPOSITORY/releases \
# -d "
# {
#   \"tag_name\": \"$TAG_NAME\",
#   \"target_commitish\": \"$GITHUB_SHA\",
#   \"name\": \"$TAG_NAME\",
#   \"draft\": false,
#   \"prerelease\": false
# }"`

# # extract release id
# rel_id=`echo ${res} | python3 -c 'import json,sys;print(json.load(sys.stdin)["id"])'`

# # upload built pdf
# curl --retry 5 -H "Authorization: token $GITHUB_TOKEN" -X POST https://uploads.github.com/repos/$GITHUB_REPOSITORY/releases/${rel_id}/assets?name=$FILE_NAME.pdf\
#   --header 'Content-Type: application/pdf'\
#   --upload-file $FILE_NAME.pdf