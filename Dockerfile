FROM alpine AS builder

MAINTAINER Martin Hellstrom <martin@hellstrom.it>

WORKDIR /root/

RUN apk add --no-cache git py-pip &&\
 git clone https://github.com/rfunix/Pompem.git pompem

FROM python:3.7-slim

COPY --from=builder /root/pompem /root/pompem
COPY run.sh /root/pompem/run.sh

WORKDIR /root/pompem

RUN pip install -r requirements.txt

ENTRYPOINT ["/bin/bash", "run.sh"]
