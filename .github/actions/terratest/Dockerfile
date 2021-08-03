# syntax=docker/dockerfile:1.3-labs
FROM golang:1.16.6-alpine3.14
RUN <<EOF
wget https://releases.hashicorp.com/terraform/1.0.3/terraform_1.0.3_linux_amd64.zip
unzip terraform_1.0.3_linux_amd64.zip
rm terraform*.zip
mv terraform /usr/bin
apk add -q gcc musl-dev
EOF
COPY entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]