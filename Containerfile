FROM python:alpine

RUN apk --no-cache add bash openssl curl jq bind-tools && \
    pip install twc-cli

ENV USER=getssl
ENV HOMEDIR=/getssl
RUN addgroup $USER && adduser -G $USER -S -h $HOMEDIR $USER

ENV PATH="${PATH}:${HOMEDIR}"
ENV TWC_CONFIG_FILE=/run/secrets/timeweb-getssl-twcrc
ENV HOME=$HOMEDIR

WORKDIR $HOMEDIR
USER $USER

COPY --chmod=700 --chown=$USER:$USER getssl/getssl $HOMEDIR
RUN install -d -m 0755 $HOMEDIR/.getssl

ADD --chown=$USER:$USER src ./src

VOLUME ["${HOMEDIR}/.getssl"]

ENTRYPOINT ["getssl", "--all"]
