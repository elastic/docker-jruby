#!/usr/bin/env bash
image=${1?image is required}
version=${2?version is required}

echo  "Test $1"
test_name=" Test java -version '$version'"
docker run -it --rm $image java -version | grep -q "openjdk version \"$version" && echo "${test_name} ... PASSED" || echo "${test_name} ... FAILED"

test_name=" Test Hello World"
docker run -it --rm $image jruby -e "puts 'Hello World" | grep -q 'Hello World' && echo "${test_name} ... PASSED" || echo "${test_name} ... FAILED"
