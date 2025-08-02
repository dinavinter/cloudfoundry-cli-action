FROM node:22.16.0

RUN apk update
RUN apk add --no-cache curl jq bash ca-certificates

ENV CF_CLI_VERSION "8.14.1"

RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_CLI_VERSION}&source=github-rel" | tar -zx -C /usr/local/bin
RUN cf install-plugin -f -r CF-Community https://github.com/cloudfoundry-community/cf-plugin-mta

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
