#!/usr/bin/env bash
exclude=${1}
if [ -n "$exclude" ] ; then
  search=$(find . -path ./$exclude -prune -o -name 'Dockerfile' -print)
else
  search=$(find . -name 'Dockerfile' -print)
fi
echo 'Push docker images'
for i in ${search}; do
  jdk_image=$(basename `dirname "$i"`)
  jruby=$(grep "JRUBY_VERSION" $i | cut -d" " -f 3)
  if [ "${jdk_image}" == "onbuild" ] ; then
    short=$(grep "FROM" $i | cut -d":" -f 2 | cut -d'-' -f1)
  else
    short=$(echo $jruby | cut -d'.' -f1-2)
  fi
  name="jruby:${short}-${jdk_image}"
  docker push ${name} >> push.log 2>&1
  if [ $? -eq 0 ] ; then
    printf '\tImage %-60s %-10s %s\n' ${name} "PUSHED"
  else
    printf '\tImage %-60s %-10s %s\n' ${name} "FAILED"
  fi
done
