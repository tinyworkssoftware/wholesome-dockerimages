FROM alpine:3.9

RUN apk add --no-cache curl tar openssl sudo bash jq python3

RUN apk --update --no-cache add postgresql-client postgresql

RUN apk add --virtual=build gcc libffi-dev musl-dev openssl-dev make python3-dev

RUN pip3 install virtualenv &&\
    python3 -m virtualenv /azure-cli

ARG AZURE_CLI_VERSION=2.1.0

RUN /azure-cli/bin/python -m pip --no-cache-dir install azure-cli==${AZURE_CLI_VERSION}
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
RUN kubectl version --client
ENV PATH="/azure-cli/bin/:$PATH"