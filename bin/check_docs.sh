#! /bin/bash

DOC_OUTPUT="$(bundle exec rake doc)"
MESSAGE="Checking for 100% documentation..."

echo -e "${DOC_OUTPUT}\n"

if [[ "$DOC_OUTPUT" =~ "100.00% documented" ]]; then
  echo "${MESSAGE} PASSED"
else
  echo "${MESSAGE} FAIL"
  exit 1
fi
