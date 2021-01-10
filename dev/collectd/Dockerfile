FROM mwaeckerlin/base

ENV CONRAINERNAME "collectd"
ENV PLUGINS "collectd-network collectd-sensors collectd-disk"
ADD --chown=somebody collectd.conf /etc/collectd/collectd.conf
RUN apk add --no-cache --purge --clean-protected -u collectd ${PLUGINS}
USER ${RUN_USER}