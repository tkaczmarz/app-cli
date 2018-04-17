#!/bin/bash

TIMEFORMAT="%R %U %S"

echo "Standalone 1"
mongo wiki --eval "db.titles.drop()"
time(mongoimport --drop --db wiki --collection titles -d wiki -c titles --type csv --file titles-big.csv -f title > output.err 2> output.out) > time.err 2> time.out
times=$(cat "time.out")
t1=($times)

echo "Standalone 2"
mongo wiki --eval "db.titles.drop()"
time(mongoimport --drop --db wiki --collection titles -d wiki -c titles --type csv --file titles-big.csv -f title > output.err 2> output.out) > time.err 2> time.out
times=$(cat "time.out")
t2=($times)

echo "Standalone 3"
mongo wiki --eval "db.titles.drop()"
time(mongoimport --drop --db wiki --collection titles -d wiki -c titles --type csv --file titles-big.csv -f title > output.err 2> output.out) > time.err 2> time.out
times=$(cat "time.out")
t3=($times)

echo "Standalone 4"
mongo wiki --eval "db.titles.drop()"
time(mongoimport --drop --db wiki --collection titles -d wiki -c titles --type csv --file titles-big.csv -f title > output.err 2> output.out) > time.err 2> time.out
times=$(cat "time.out")
t4=($times)

echo "Standalone 5"
mongo wiki --eval "db.titles.drop()"
time(mongoimport --drop --db wiki --collection titles -d wiki -c titles --type csv --file titles-big.csv -f title > output.err 2> output.out) > time.err 2> time.out
times=$(cat "time.out")
t5=($times)

real_sum=$(echo "${t1[0]}+${t2[0]}+${t3[0]}+${t4[0]}+${t5[0]}" | bc)
real_avg=$(echo "$real_sum/5" | bc -l)

user_sum=$(echo "${t1[1]}+${t2[1]}+${t3[1]}+${t4[1]}+${t5[1]}" | bc)
user_avg=$(echo "$user_sum/5" | bc -l)

sys_sum=$(echo "${t1[2]}+${t2[2]}+${t3[2]}+${t4[2]}+${t5[2]}" | bc)
sys_avg=$(echo "$sys_sum/5" | bc -l)

printf "[cols='1,1,2,2', options='header']
.Standalone
|===
|Nr próbki |Real |User |System
| 1  | ${t1[0]} |${t1[1]}| ${t1[2]}
| 2  | ${t2[0]} |${t2[1]}| ${t2[2]}
| 3  | ${t3[0]} |${t3[1]}| ${t3[2]}
| 4  | ${t4[0]} |${t4[1]}| ${t4[2]}
| 5  | ${t5[0]} |${t5[1]}| ${t5[2]}
|Średnia|" > summary-titles.adoc


echo "scale=3;$real_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-titles.adoc
printf "|" >> summary-titles.adoc
echo "scale=3;$user_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-titles.adoc
printf "|" >> summary-titles.adoc
echo "scale=3;$sys_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-titles.adoc
printf "
|===\n" >> summary-titles.adoc

################################

echo "Standalone 100k 1"
mongo wiki --eval "db.titles.drop()"
time(mongoimport --drop --db wiki --collection titles -d wiki -c titles --type csv --file titles.csv -f title > output.err 2> output.out) > time.err 2> time.out
times=$(cat "time.out")
t1=($times)

echo "Standalone 100k 2"
mongo wiki --eval "db.titles.drop()"
time(mongoimport --drop --db wiki --collection titles -d wiki -c titles --type csv --file titles.csv -f title > output.err 2> output.out) > time.err 2> time.out
times=$(cat "time.out")
t2=($times)

echo "Standalone 100k 3"
mongo wiki --eval "db.titles.drop()"
time(mongoimport --drop --db wiki --collection titles -d wiki -c titles --type csv --file titles.csv -f title > output.err 2> output.out) > time.err 2> time.out
times=$(cat "time.out")
t3=($times)

echo "Standalone 100k 4"
mongo wiki --eval "db.titles.drop()"
time(mongoimport --drop --db wiki --collection titles -d wiki -c titles --type csv --file titles.csv -f title > output.err 2> output.out) > time.err 2> time.out
times=$(cat "time.out")
t4=($times)

echo "Standalone 100k 5"
mongo wiki --eval "db.titles.drop()"
time(mongoimport --drop --db wiki --collection titles -d wiki -c titles --type csv --file titles.csv -f title > output.err 2> output.out) > time.err 2> time.out
times=$(cat "time.out")
t5=($times)

real_sum=$(echo "${t1[0]}+${t2[0]}+${t3[0]}+${t4[0]}+${t5[0]}" | bc)
real_avg=$(echo "$real_sum/5" | bc -l)

user_sum=$(echo "${t1[1]}+${t2[1]}+${t3[1]}+${t4[1]}+${t5[1]}" | bc)
user_avg=$(echo "$user_sum/5" | bc -l)

sys_sum=$(echo "${t1[2]}+${t2[2]}+${t3[2]}+${t4[2]}+${t5[2]}" | bc)
sys_avg=$(echo "$sys_sum/5" | bc -l)

printf "[cols='1,1,2,2', options='header']
.Standalone  100k
|===
|Nr próbki |Real |User |System
| 1  | ${t1[0]} |${t1[1]}| ${t1[2]}
| 2  | ${t2[0]} |${t2[1]}| ${t2[2]}
| 3  | ${t3[0]} |${t3[1]}| ${t3[2]}
| 4  | ${t4[0]} |${t4[1]}| ${t4[2]}
| 5  | ${t5[0]} |${t5[1]}| ${t5[2]}
|Średnia|" >> summary-titles.adoc


echo "scale=3;$real_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-titles.adoc
printf "|" >> summary-titles.adoc
echo "scale=3;$user_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-titles.adoc
printf "|" >> summary-titles.adoc
echo "scale=3;$sys_avg" | bc | awk '{printf "%.3f", $0 -n}' >> summary-titles.adoc
printf "
|===\n" >> summary-titles.adoc
