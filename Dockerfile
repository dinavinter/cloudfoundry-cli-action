FROM alpine:latest

RUN apk update
RUN apk add --no-cache curl jq bash ca-certificates

# Download and install nvm:
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
# \. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
RUN nvm install 22

# Verify the Node.js version:
RUN node -v # Should print "v24.5.0".
RUN nvm current # Should print "v24.5.0".

# Verify npm version:
RUN npm -v # Should print "11.5.1".


ENV CF_CLI_VERSION "8.14.1"

RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_CLI_VERSION}&source=github-rel" | tar -zx -C /usr/local/bin
RUN cf install-plugin -f -r CF-Community https://github.com/cloudfoundry-community/cf-plugin-mta

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
