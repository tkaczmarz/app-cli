#!/bin/bash

TIMEFORMAT="%R %U %S"

echo "Replica set default 1"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t1=($times)

echo "Replica set default 2"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t2=($times)

echo "Replica set default 3"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t3=($times)

echo "Replica set default 4"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t4=($times)

echo "Replica set default 5"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t5=($times)

real_sum=$(echo "${t1[0]}+${t2[0]}+${t3[0]}+${t4[0]}+${t5[0]}" | bc)
real_avg=$(echo "$real_sum/5" | bc -l)

user_sum=$(echo "${t1[1]}+${t2[1]}+${t3[1]}+${t4[1]}+${t5[1]}" | bc)
user_avg=$(echo "$user_sum/5" | bc -l)

sys_sum=$(echo "${t1[2]}+${t2[2]}+${t3[2]}+${t4[2]}+${t5[2]}" | bc)
sys_avg=$(echo "$sys_sum/5" | bc -l)

printf "[cols='1,1,2,2', options='header']
.Replica set default
|===
|Nr próbki |Real |User |System
| 1  | ${t1[0]} |${t1[1]}| ${t1[2]}
| 2  | ${t2[0]} |${t2[1]}| ${t2[2]}
| 3  | ${t3[0]} |${t3[1]}| ${t3[2]}
| 4  | ${t4[0]} |${t4[1]}| ${t4[2]}
| 5  | ${t5[0]} |${t5[1]}| ${t5[2]}
|Średnia|" >> summary-pktadr.adoc


echo "scale=3;$real_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "|" >> summary-pktadr.adoc
echo "scale=3;$user_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "|" >> summary-pktadr.adoc
echo "scale=3;$sys_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "
|===\n" >> summary-pktadr.adoc

#####################################

echo "Replica set writeConcern {w:1, j:false} 1"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:1,j:false,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t1=($times)

echo "Replica set writeConcern {w:1, j:false} 2"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:1,j:false,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t2=($times)

echo "Replica set writeConcern {w:1, j:false} 3"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:1,j:false,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t3=($times)

echo "Replica set writeConcern {w:1, j:false} 4"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:1,j:false,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t4=($times)

echo "Replica set writeConcern {w:1, j:false} 5"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:1,j:false,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t5=($times)

real_sum=$(echo "${t1[0]}+${t2[0]}+${t3[0]}+${t4[0]}+${t5[0]}" | bc)
real_avg=$(echo "$real_sum/5" | bc -l)

user_sum=$(echo "${t1[1]}+${t2[1]}+${t3[1]}+${t4[1]}+${t5[1]}" | bc)
user_avg=$(echo "$user_sum/5" | bc -l)

sys_sum=$(echo "${t1[2]}+${t2[2]}+${t3[2]}+${t4[2]}+${t5[2]}" | bc)
sys_avg=$(echo "$sys_sum/5" | bc -l)

printf "[cols='1,1,2,2', options='header']
.Replica set writeConcern {w:1, j:false}
|===
|Nr próbki |Real |User |System
| 1  | ${t1[0]} |${t1[1]}| ${t1[2]}
| 2  | ${t2[0]} |${t2[1]}| ${t2[2]}
| 3  | ${t3[0]} |${t3[1]}| ${t3[2]}
| 4  | ${t4[0]} |${t4[1]}| ${t4[2]}
| 5  | ${t5[0]} |${t5[1]}| ${t5[2]}
|Średnia|" >> summary-pktadr.adoc


echo "scale=3;$real_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "|" >> summary-pktadr.adoc
echo "scale=3;$user_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "|" >> summary-pktadr.adoc
echo "scale=3;$sys_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "

|===\n" >> summary-pktadr.adoc

#####################################

echo "Replica set writeConcern {w:1, j:true} 1"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:1,j:true,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t1=($times)

echo "Replica set writeConcern {w:1, j:true} 2"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:1,j:true,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t2=($times)

echo "Replica set writeConcern {w:1, j:true} 3"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:1,j:true,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t3=($times)

echo "Replica set writeConcern {w:1, j:true} 4"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:1,j:true,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t4=($times)

echo "Replica set writeConcern {w:1, j:true} 5"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:1,j:true,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t5=($times)

real_sum=$(echo "${t1[0]}+${t2[0]}+${t3[0]}+${t4[0]}+${t5[0]}" | bc)
real_avg=$(echo "$real_sum/5" | bc -l)

user_sum=$(echo "${t1[1]}+${t2[1]}+${t3[1]}+${t4[1]}+${t5[1]}" | bc)
user_avg=$(echo "$user_sum/5" | bc -l)

sys_sum=$(echo "${t1[2]}+${t2[2]}+${t3[2]}+${t4[2]}+${t5[2]}" | bc)
sys_avg=$(echo "$sys_sum/5" | bc -l)

printf "[cols='1,1,2,2', options='header']
.Replica set writeConcern {w:1, j:true}
|===
|Nr próbki |Real |User |System
| 1  | ${t1[0]} |${t1[1]}| ${t1[2]}
| 2  | ${t2[0]} |${t2[1]}| ${t2[2]}
| 3  | ${t3[0]} |${t3[1]}| ${t3[2]}
| 4  | ${t4[0]} |${t4[1]}| ${t4[2]}
| 5  | ${t5[0]} |${t5[1]}| ${t5[2]}
|Średnia|" >> summary-pktadr.adoc


echo "scale=3;$real_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "|" >> summary-pktadr.adoc
echo "scale=3;$user_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "|" >> summary-pktadr.adoc
echo "scale=3;$sys_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "
|===\n" >> summary-pktadr.adoc

#####################################

echo "Replica set writeConcern {w:2, j:false} 1"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:2,j:false,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t1=($times)

echo "Replica set writeConcern {w:2, j:false} 2"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:2,j:false,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t2=($times)

echo "Replica set writeConcern {w:2, j:false} 3"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:2,j:false,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t3=($times)

echo "Replica set writeConcern {w:2, j:false} 4"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:2,j:false,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t4=($times)

echo "Replica set writeConcern {w:2, j:false} 5"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:2,j:false,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t5=($times)

real_sum=$(echo "${t1[0]}+${t2[0]}+${t3[0]}+${t4[0]}+${t5[0]}" | bc)
real_avg=$(echo "$real_sum/5" | bc -l)

user_sum=$(echo "${t1[1]}+${t2[1]}+${t3[1]}+${t4[1]}+${t5[1]}" | bc)
user_avg=$(echo "$user_sum/5" | bc -l)

sys_sum=$(echo "${t1[2]}+${t2[2]}+${t3[2]}+${t4[2]}+${t5[2]}" | bc)
sys_avg=$(echo "$sys_sum/5" | bc -l)

printf "[cols='1,1,2,2', options='header']
.Replica set writeConcern {w:2, j:false}
|===
|Nr próbki |Real |User |System
| 1  | ${t1[0]} |${t1[1]}| ${t1[2]}
| 2  | ${t2[0]} |${t2[1]}| ${t2[2]}
| 3  | ${t3[0]} |${t3[1]}| ${t3[2]}
| 4  | ${t4[0]} |${t4[1]}| ${t4[2]}
| 5  | ${t5[0]} |${t5[1]}| ${t5[2]}
|Średnia|" >> summary-pktadr.adoc


echo "scale=3;$real_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "|" >> summary-pktadr.adoc
echo "scale=3;$user_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "|" >> summary-pktadr.adoc
echo "scale=3;$sys_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "
|===\n" >> summary-pktadr.adoc

#####################################

echo "Replica set writeConcern {w:2, j:true} 1"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:2,j:true,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t1=($times)

echo "Replica set writeConcern {w:2, j:true} 2"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:2,j:true,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t2=($times)

echo "Replica set writeConcern {w:2, j:true} 3"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:2,j:true,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t3=($times)

echo "Replica set writeConcern {w:2, j:true} 4"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:2,j:true,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t4=($times)

echo "Replica set writeConcern {w:2, j:true} 5"
mongo pktadr --eval "db.data.drop()"
time(gunzip -c 2018_04_16_08_17_44__14_mazowieckie.json.gz | \
jq --compact-output '{
place: .properties.miejscowosc,
street: .properties.ulica,
zipcode: .properties.kodPocztowy,
nr: .properties.numerPorzadkowy,
status: .properties.status,
geometry,
admunit: .properties.jednostkaAdmnistracyjna
}' | \
mongoimport --host replica/localhost:27017,localhost:27018,localhost:27019 -d pktadr -c data --writeConcern '{w:2,j:true,wtimeout:500}' > example.err 2> example.out)> time.err 2> time.out
times=$(cat "time.out")
t5=($times)

real_sum=$(echo "${t1[0]}+${t2[0]}+${t3[0]}+${t4[0]}+${t5[0]}" | bc)
real_avg=$(echo "$real_sum/5" | bc -l)

user_sum=$(echo "${t1[1]}+${t2[1]}+${t3[1]}+${t4[1]}+${t5[1]}" | bc)
user_avg=$(echo "$user_sum/5" | bc -l)

sys_sum=$(echo "${t1[2]}+${t2[2]}+${t3[2]}+${t4[2]}+${t5[2]}" | bc)
sys_avg=$(echo "$sys_sum/5" | bc -l)

printf "[cols='1,1,2,2', options='header']
.Replica set writeConcern {w:2, j:true}
|===
|Nr próbki |Real |User |System
| 1  | ${t1[0]} |${t1[1]}| ${t1[2]}
| 2  | ${t2[0]} |${t2[1]}| ${t2[2]}
| 3  | ${t3[0]} |${t3[1]}| ${t3[2]}
| 4  | ${t4[0]} |${t4[1]}| ${t4[2]}
| 5  | ${t5[0]} |${t5[1]}| ${t5[2]}
|Średnia|" >> summary-pktadr.adoc


echo "scale=3;$real_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "|" >> summary-pktadr.adoc
echo "scale=3;$user_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "|" >> summary-pktadr.adoc
echo "scale=3;$sys_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-pktadr.adoc
printf "
|===\n" >> summary-pktadr.adoc
