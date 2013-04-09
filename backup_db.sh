#!/bin/bash
suffix=$(date +%Y-%m-%d_%H.%M.%S)
wdir=/home/teampse4/backup
# count existing backups
count=ls ${wdir} -1 | wc -l

# remove oldest if more than 29
if [ $count -gt 29 ]
then
  rm -f `ls ${wdir} | sort -n | head -1`
fi

# create new backup and compress it
mongodump -o $wdir/mongo-$suffix
tar -czf $wdir/mongo-$suffix.tar.gz $wdir/mongo-$suffix
rm -rf $wdir/mongo-$suffix
