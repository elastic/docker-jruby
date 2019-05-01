FROM openjdk:7-jdk-alpine

RUN apk add --no-cache \
      bash \
      libc6-compat

ENV JRUBY_VERSION 9.1.17.0
ENV JRUBY_SHA256 6a22f7bf8fef1a52530a9c9781a9d374ad07bbbef0d3d8e2af0ff5cbead0dfd5
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
