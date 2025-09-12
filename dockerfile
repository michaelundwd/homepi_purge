
############################################################################
#   Docker image that purges out-dated videos on homeserver                #
#   Requires the following bind mounts in Portainer:                       #
#   /homeserver_video_reargarden > /mnt/homeserver_video_reargarden (sync) #
#   /homepi_opt > /opt                                                     #
#   entrypoint.sh ???????????????????????????????????????????????????????  #
#   last updated 13/09/2025                                                #
############################################################################

# FROM alpine:latest


# coreutils only needed to run the sed code in entrypoint


# COPY entrypoint.sh .
# RUN chmod +x ./entrypoint.sh

# ENTRYPOINT ["./entrypoint.sh"]

# CMD ["crond","-f"] 

##############################################################
# new version for purge alone
##############################################################

# needs modification to allow for alpine ilo ubuntu eg apk & file containing cron...

FROM alpine:latest

RUN mkdir /homeserver_video_reargarden
RUN apk add tzdata coreutils --no-cache

# Add crontab file in the cron directory
ADD /opt/purge/purge-schedule /etc/cron.d/hello-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/hello-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

#Install Cron
RUN apt-get update
RUN apt-get -y install cron

ENV TZ="Europe/London"
# need the next line as TZ line has no effect
RUN cp /usr/share/zoneinfo/Europe/London /etc/localtime

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
