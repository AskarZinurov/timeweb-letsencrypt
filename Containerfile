FROM python:slim

ENV USER getssl
ENV HOMEDIR /home/$USER
ENV PATH="${PATH}:/home/${USER}"
ENV TWC_CONFIG_FILE=/run/secrets/timeweb-getssl-twcrc

RUN groupadd $USER && useradd -m $USER -g $USER

RUN pip install twc-cli
COPY --chown=$USER:$USER --chmod=700 getssl/getssl $HOMEDIR
RUN install -d -m 0755 -o $USER -g $USER $HOMEDIR/.getssl

USER $USER
WORKDIR $HOMEDIR
VOLUME $HOMEDIR/.getssl
