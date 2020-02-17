FROM ubuntu:18.04

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -yqq \
        python3 \
        python3-pip

RUN pip3 install flask


RUN apt-get install -yqq iptables \
        iproute2 \
	systemd

#RUN apt-get update && apt-get install -yqq xinetd telnetd

WORKDIR /home/ubuntu

COPY ./allin.sh ./openvpn-docker.sh ./	 

RUN chmod +x openvpn-docker.sh

RUN chmod +x allin.sh

#ENTRYPOINT ["bash"]

#CMD ["./allin.sh"]
