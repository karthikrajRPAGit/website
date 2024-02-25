#!/bin/sh
if [ `docker images | grep intelassess | grep -c latest` -eq 1 ]
then
  exit 0;
else
  exit 1;
fi
