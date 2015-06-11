FROM ubuntu:14.04
MAINTAINER Carlos Killpack <carlos@zulumarketing.com>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update > /dev/null \
    && apt-get upgrade -y > /dev/null \
    && apt-get clean > /dev/null \
    && apt-get update > /dev/null \
    && apt-get install -y supervisor postgresql > /dev/null \
    && apt-get clean > /dev/null

RUN mkdir -p /root/bin
COPY run.sh /root/bin/run.sh
COPY pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
COPY supervisor.conf /etc/supervisor/supervisor.conf

VOLUME ["/var/lib/postgresql"]

USER root
EXPOSE 5432
ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisor.conf"]
