#!/bin/bash

(
	set -e

	JRUBY_VERSION=$(< VERSION)
	SHA="$(curl -SLfs https://repo1.maven.org/maven2/org/jruby/jruby-dist/${JRUBY_VERSION}/jruby-dist-${JRUBY_VERSION}-bin.tar.gz.sha256)"
	SHA=$(printf '%s' ${SHA})

	for i in $(find . -name 'Dockerfile'); do
		# exclude JDK 7 as it does require 9.1
		if ! [[ $i =~ .*/7-.* ]] ; then
			echo setting version on "$i"
			sed -i "s/ENV\ JRUBY_VERSION.*/ENV JRUBY_VERSION ${JRUBY_VERSION}/" "$i"
			sed -i "s/ENV\ JRUBY_SHA256.*/ENV JRUBY_SHA256 ${SHA}/" "$i"
		fi
	done

	echo versions updated to $JRUBY_VERSION @ $SHA
)
