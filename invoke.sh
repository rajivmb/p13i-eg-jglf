#!/bin/bash

# Load the necessary arguments from file
. setup_args.txt

read -t ${inputTimeout} -p "Enter component name [${projectName}], you have ${inputTimeout}s: " input

projectName=${input:-$projectName}
greetingName="github.com/rajivmb"

read -t ${inputTimeout} -p "Enter greeting name [${greetingName}], you have ${inputTimeout}s: " input

greetingName=${input:-$greetingName}

functionName=`aws cloudformation describe-stacks \
    --stack-name "${projectName}-DEPLOY" \
    --query "Stacks[*].Outputs[?OutputKey=='P13iMITEgJavaLambdaFunctionArn'].OutputValue" \
    --output text`

aws lambda invoke --function-name "${functionName}" --payload '{"name":"'${greetingName}'"}' response.txt && cat response.txt && rm response.txt && echo
