#!/usr/bin/env bash

echo 'Generate docker images'
for i in $(find . -name 'Dockerfile'); do
  jdk_image=$(basename `dirname "$i"`)
  jruby=$(grep "JRUBY_VERSION" $i | cut -d" " -f 3)
  if [ "${jdk_image}" == "onbuild" ] ; then
    short=$(grep "FROM" $i | cut -d":" -f 2 | cut -d'-' -f1)
  else
    short=$(echo $jruby | cut -d'.' -f1-2)
  fi
  docker build --tag jruby:${short}-${jdk_image} -< $i
done

echo 'Test docker images'
for i in $(find . -name 'Dockerfile'); do
  jdk_image=$(basename `dirname "$i"`)
  jdk_version=$(echo $jdk_image | cut -d'-' -f1)
  jruby=$(grep "JRUBY_VERSION" $i | cut -d" " -f 3)
  if [ "${jdk_image}" == "onbuild" ] ; then
    short=$(grep "FROM" $i | cut -d":" -f 2 | cut -d'-' -f1)
  else
    short=$(echo $jruby | cut -d'.' -f1-2)
  fi
  ./tests/test.sh jruby:${short}-${jdk_image} $jdk_version
done
