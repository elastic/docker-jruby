apk add --no-cache --virtual .build-deps curl tar

mkdir -p /opt/jruby
curl -fSL https://repo1.maven.org/maven2/org/jruby/jruby-dist/${JRUBY_VERSION}/jruby-dist-${JRUBY_VERSION}-bin.tar.gz -o /tmp/jruby.tar.gz
echo "$JRUBY_SHA256 */tmp/jruby.tar.gz" | sha256sum -c -
tar -zx --strip-components=1 -f /tmp/jruby.tar.gz -C /opt/jruby
rm /tmp/jruby.tar.gz
ln -s /opt/jruby/bin/jruby /usr/local/bin/ruby
apk del .build-deps

mkdir -p /opt/jruby/etc

echo 'install: --no-document' >> /opt/jruby/etc/gemrc
echo 'update: --no-document' >> /opt/jruby/etc/gemrc

# install bundler, gem requires bash to work
gem install bundler rake net-telnet xmlrpc
