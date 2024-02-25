#!/bin/sh
build_number=$1
if [ `docker images | grep intel-assess | grep -c $build_number` -eq 1 ]
then
  exit 0;
else
  exit 1;
fi
