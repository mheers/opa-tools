ARG ALPINE_TOOLS_VERSION=3.20.3

# cosign and raygun
ARG COSIGN_VERSION=2.4.1
ARG RAYGUN_VERSION=0.1.5
ARG RAYGUN2X_VERSION=0.0.1

FROM bitnami/cosign:${COSIGN_VERSION} AS cosign
FROM mheers/opa-raygun:v${RAYGUN_VERSION} AS raygun
FROM mheers/raygun2x:v${RAYGUN2X_VERSION} AS raygun2x

FROM --platform=$BUILDPLATFORM mheers/alpine-tools:${ALPINE_TOOLS_VERSION}

# policy cli
ARG POLICY_CLI_VERSION=0.2.21
ENV POLICY_CLI_VERSION=${POLICY_CLI_VERSION}
RUN cd /tmp && \
    wget https://github.com/opcr-io/policy/releases/download/v${POLICY_CLI_VERSION}/policy${POLICY_CLI_VERSION}_linux_x86_64.zip && \
    unzip policy${POLICY_CLI_VERSION}_linux_x86_64.zip && \
    mv ./policy /usr/local/bin

# opa cli
ARG OPA_VERSION=0.69.0
ENV OPA_VERSION=${OPA_VERSION}
RUN curl -L -o /usr/bin/opa https://openpolicyagent.org/downloads/v${OPA_VERSION}/opa_linux_amd64_static && \
    chmod +x /usr/bin/opa

# oras cli
ARG ORAS_VERSION=1.2.0
ENV ORAS_VERSION=${ORAS_VERSION}
RUN curl -LO https://github.com/oras-project/oras/releases/download/v${ORAS_VERSION}/oras_${ORAS_VERSION}_linux_amd64.tar.gz && \
    mkdir -p oras-install/ && \
    tar -zxf oras_${ORAS_VERSION}_*.tar.gz -C oras-install/ && \
    sudo mv oras-install/oras /usr/local/bin/ && \
    rm -rf oras_${ORAS_VERSION}_*.tar.gz oras-install/

# regal cli
ARG REGAL_VERSION=0.28.0
ENV REGAL_VERSION=${REGAL_VERSION}
RUN curl -L -o /usr/bin/regal https://github.com/StyraInc/regal/releases/download/v${REGAL_VERSION}/regal_Linux_x86_64 && \
    chmod +x /usr/bin/regal

# raygun cli
COPY --from=raygun /raygun /usr/bin/raygun

# raygun2x cli
COPY --from=raygun2x /usr/local/bin/raygun2x /usr/bin/raygun2x

# cosign
COPY --from=cosign /opt/bitnami/cosign/bin/cosign /usr/local/bin/cosign

ENTRYPOINT [ "bash" ]
