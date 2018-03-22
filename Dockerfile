FROM registry.fedoraproject.org/fedora:28

ENV LANG C.UTF-8

RUN dnf -y update

RUN dnf -y install git \
                   python3 \
		   python3-virtualenv \
		   python2-virtualenv

RUN virtualenv --python=python3.6 /opt/insteon-mqtt

RUN /opt/insteon-mqtt/bin/pip install git+https://github.com/TD22057/insteon-mqtt.git

RUN mkdir -p /conf /data

RUN groupadd -g 6001 insteon-mqtt
RUN useradd --uid 6001 --gid insteon-mqtt --home-dir /opt/insteon-mqtt --no-create-home --shell /usr/bin/bash insteon-mqtt
RUN chown -R insteon-mqtt:insteon-mqtt /conf /data

VOLUME /conf
VOLUME /data
USER insteon-mqtt
WORKDIR /opt/insteon-mqtt
ENTRYPOINT ["/opt/insteon-mqtt/bin/insteon-mqtt", "/conf/config.yaml", "start"]

# Local Variables:
# indent-tabs-mode: nil
# End:
