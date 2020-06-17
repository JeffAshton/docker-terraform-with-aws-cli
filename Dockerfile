FROM hashicorp/terraform:0.11.14

ENTRYPOINT []
COPY ./assume-role.sh /usr/bin/aws-assume-role

RUN \
	apk add --no-cache jq python py-pip \
	&& pip install awscli \
	&& apk del py-pip \
	&& rm -rf /var/lib/apt/lists/* \
	&& aws --version
