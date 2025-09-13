
############################################################################
#   Docker image that purges out-dated videos on homeserver                #
#   Requires the following bind mounts in Portainer:                       #
#   /homeserver_video_reargarden > /mnt/homeserver_video_reargarden (sync) #
#   /homepi_opt > /opt                                                     #
#   entrypoint.sh ???????????????????????????????????????????????????????  #
#   last updated 13/09/2025                                                #
############################################################################

##############################################################
# new version for purge alone
##############################################################

FROM alpine:latest

RUN mkdir /homeserver_video_reargarden
RUN apk add tzdata coreutils --no-cache

COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

ENV TZ="Europe/London"
# need the next line as TZ line has no effect
RUN cp /usr/share/zoneinfo/Europe/London /etc/localtime

# Run the command on container startup
# CMD cron && tail -f /var/log/cron.log
