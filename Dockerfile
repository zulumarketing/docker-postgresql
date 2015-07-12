FROM ubuntu:14.04
MAINTAINER Carlos Killpack <carlos@zulumarketing.com>

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

VOLUME ["/var/lib/postgresql"]

RUN apt-get update > /dev/null \
    && apt-get upgrade -y > /dev/null \
    && apt-get update > /dev/null \
    && apt-get install -y supervisor postgresql > /dev/null \
    && apt-get clean > /dev/null \
    && chown -R postgres /var/lib/postgres \
    && chmod -R 700 /var/lib/postgres \
    && pg_createcluster --locale en_US.UTF-8 9.3 main

COPY postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
COPY pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
COPY supervisor.conf /etc/supervisor/supervisor.conf

USER root
EXPOSE 5432
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisor.conf"]
