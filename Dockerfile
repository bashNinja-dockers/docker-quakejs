FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="bashNinja"

ENV PORT=8080

RUN \
 echo "**** install build env ****" && \
 apt-get update && \
 apt-get install -y \
        git \
        gnupg \
	libfontconfig && \
 curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
 echo 'deb https://deb.nodesource.com/node_12.x bionic main' \
	> /etc/apt/sources.list.d/nodesource.list && \
 apt-get update && \
 apt-get install -y \
	nodejs && \
 echo "**** install quakejs ****" && \
 mkdir -p \
	/app/quakejs && \
 git clone --recurse-submodules https://github.com/inolen/quakejs /app/quakejs/ && \
 echo "**** install node modules ****" && \
 npm config set unsafe-perm true && \
 npm install --production \
	--prefix /app/quakejs && \
 echo "**** clean up ****" && \
 rm -rf \
	/root \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/* && \
 mkdir -p \
	/root



EXPOSE 27960

# ----

# Main
ENV QJS_FS_GAME="baseq3"
ENV QJS_DEDICATED="1"
ENV QJS_SERVER_CONFIG="server.cfg"

# Server
ENV QJS_SV_HOSTNAME="801Labs Server"
ENV QJS_SV_MAXCLIENTS="20"
ENV QJS_RCONPASSWORD="hacktheplanet"

# Game

# Game mode  0 (DM), 1 (T), 3 (TDM), 4 (CTF)
ENV QJS_G_GAMETYPE="0"
# Maps
# 0 q3dm1, q3dm7, q3dm17, q3tourney2, pro-q3tourney2, pro-q3tourney4, pro-q3dm6, pro-q3dm13
# 1 q3dm1, q3tourney2, pro-q3tourney2, pro-q3tourney4, pro-q3dm6, pro-q3dm13
# 3 q3dm7, pro-q3tourney2, pro-q3tourney4, pro-q3dm6, pro-q3dm13
# 4 q3tourney6_ctf

ENV QJS_MAP="q3dm7"
ENV QJS_CAPTURELIMIT="8"
ENV QJS_FRAGLIMIT="10"
ENV QJS_TIMELIMIT="10"

# Bots
# Number of bots, 1-5
ENV QJS_BOT_MINPLAYERS="4"
# Bot difficulty 1-5
ENV QJS_BOT_SKILL="1"

# -------

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8080
EXPOSE 27960
VOLUME /config
