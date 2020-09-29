#!/bin/sh

PROJECT_NAME=$1
mv /srv/$PROJECT_NAME /srv/recycle-bin/srv
mv /opt/repos/$PROJECT_NAME.git /srv/recycle-bin/repo
