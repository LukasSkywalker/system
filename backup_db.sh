#!/bin/bash
suffix=$(date +%w)
wdir=/home/teampse4/backup

rm $wdir/mongo-$suffix.tar.gz -rf
mongodump -o $wdir/mongo-$suffix
tar -czf $wdir/mongo-$suffix.tar.gz $wdir/mongo-$suffix
rm -rf $wdir/mongo-$suffix
