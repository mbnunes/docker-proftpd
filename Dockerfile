FROM		mbnunes/vlk-ubuntu

ENV     	DEBIAN_FRONTEND noninteractive

RUN     	apt-get update -qq && \
	        apt-get install -y proftpd-basic proftpd-mod-mysql nginx && \
	        apt-get clean autoclean && \
	        apt-get autoremove --yes && \
	        addgroup --system --gid 101 nginx && \
    		adduser --system --disabled-login --ingroup nginx --no-create-home \
		--home /nonexistent --gecos "nginx user" --shell /bin/false --uid 101 nginx && \
	        rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN		sed -i "s/# DefaultRoot/DefaultRoot/" /etc/proftpd/proftpd.conf

EXPOSE		20 21

ADD		docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh
ENTRYPOINT	["/usr/local/sbin/docker-entrypoint.sh"]

CMD		["proftpd", "--nodaemon"]
