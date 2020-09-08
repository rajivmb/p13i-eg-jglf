#!/bin/bash

#<REF/> https://stackoverflow.com/a/12694189
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${DIR}" ]]; then DIR="${PWD}"; fi
printf "DIR is %s\n" ${DIR}

# Load the necessary arguments from file
. ${DIR}/setup_args.txt

read -t ${inputTimeout} -p "Enter component name [${projectName}] or press <Enter> to accept default, you have ${inputTimeout}s: " input

projectName=${input:-$projectName}
greetingName="github.com/rajivmb"

printf "\n"

read -t ${inputTimeout} -p "Enter greeting name [${greetingName}], you have ${inputTimeout}s: " input

greetingName=${input:-$greetingName}

functionName=`aws cloudformation describe-stacks \
    --stack-name "${projectName}-DEPLOY" \
    --query "Stacks[*].Outputs[?OutputKey=='P13iEgJavaLambdaFunctionArn'].OutputValue" \
    --output text`

aws lambda invoke --function-name "${functionName}" --payload '{"name":"'${greetingName}'"}' response.txt && cat response.txt && rm response.txt && echo
