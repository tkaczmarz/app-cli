#!/bin/bash

mkdir data
mkdir replica
mkdir replica2

mongod --dbpath data --replSet replica --port 27017 &
mongod --dbpath replica --replSet replica --port 27018 &
mongod --dbpath replica2 --replSet replica --port 27019 &
sleep 5
config="{ _id: 'replica', members:[
            { _id: 0, host: 'localhost:27017' },
            { _id: 1, host: 'localhost:27018' },
            { _id: 2, host: 'localhost:27019' }
        ]}"

mongo localhost:27017 --eval "JSON.stringify(db.adminCommand({'replSetInitiate' : $config}))"
