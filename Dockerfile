# hadolint ignore=DL3007
FROM rluisr/github-runner-base:latest

ENV AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache
RUN mkdir -p /opt/hostedtoolcache

ARG GH_RUNNER_VERSION="2.277.1"
ARG TARGETPLATFORM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /actions-runner
COPY install_actions.sh /actions-runner

RUN chmod +x /actions-runner/install_actions.sh \
  && /actions-runner/install_actions.sh ${GH_RUNNER_VERSION} ${TARGETPLATFORM} \
  && rm /actions-runner/install_actions.sh

COPY token.sh entrypoint.sh /
RUN chmod +x /token.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/actions-runner/bin/runsvc.sh"]
