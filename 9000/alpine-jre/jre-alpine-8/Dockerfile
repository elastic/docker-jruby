FROM openjdk:8-jre-alpine

RUN apk add --no-cache \
      bash \
      libc6-compat

ENV JRUBY_VERSION 9.2.7.0
ENV JRUBY_SHA256 da7c1a5ce90015c0bafd4bca0352294e08fe1c9ec049ac51e82fe57ed50e1348
ENV PATH /opt/jruby/bin:$PATH

COPY install.sh /src/install.sh
RUN cd /src && ./install.sh

# install things globally, for great justice
# and don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
    BUNDLE_BIN="$GEM_HOME/bin" \
    BUNDLE_SILENCE_ROOT_WARNING=1 \
    BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
    && chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

CMD [ "irb" ]
