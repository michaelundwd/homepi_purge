##########################################################################
# Purge image to remove out-dated videos on homeserver & all .txt files  #
# Requires the following bind mounts in Portainer:                       #
# /homepi_home_mju_videos > /home/mju/Videos                             #
# /homepi_opt > /opt                                                     #
# /homeserver_video_reargarden > /mnt/homeserver_video_reargarden (sync) #
# entrypoint.sh calls the purge/startup-script.sh that sets the schedule #
# last updated 14/09/2025                                                #
##########################################################################

FROM alpine:latest

RUN mkdir /homepi_home_mju_videos /homepi_opt /homeserver_video_reargarden 
RUN apk add tzdata coreutils --no-cache

ENV TZ="Europe/London"
# need the next line as TZ line has no effect
RUN cp /usr/share/zoneinfo/Europe/London /etc/localtime

COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["/homepi_opt/purge/startup.sh"]

