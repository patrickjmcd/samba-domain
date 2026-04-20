FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN \
    apt-get update &&\
    apt-get install -y \
        pkg-config \
        attr \
        acl \
        samba \
        smbclient \
        ldap-utils \
        winbind \
        libnss-winbind \
        libpam-winbind \
        krb5-user \
        krb5-kdc \
        supervisor \
        openvpn \
        inetutils-ping \
        ldb-tools \
        vim \
        curl \
        dnsutils \
        ntp &&\
    apt-get clean autoclean &&\
    apt-get autoremove --yes &&\
    rm -rf /var/lib/{apt,dpkg,cache,log}/ &&\
    rm -fr /tmp/* /var/tmp/*

VOLUME [ "/var/lib/samba", "/etc/samba/external" ]

COPY init.sh /init.sh
COPY domain.sh /domain.sh
RUN chmod 755 /init.sh /domain.sh
CMD ["/init.sh"]
