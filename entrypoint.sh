#!/bin/sh
# entrypoint.sh
# Runs the startup script in the host that copies the daily video folder tidy up schedule to the container at startup and runs the video move routines
# Last modified 01/09/2025
exec ./homepi_opt/purge/startup-script.sh
#