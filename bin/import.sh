#! /bin/bash

baza="wiki"
kolekcja="titles"
plik="titles.csv"

mongo $baza --eval "db.$kolekcja.drop()"

mongoimport -d $baza -c $kolekcja --type csv --file $plik -f title