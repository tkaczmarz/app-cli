# Projekt na zaliczenie

W projekcie korzystam z [bazy danych](https://www.kaggle.com/residentmario/wikipedia-article-titles) zawierającej wszystkie tytuły artykułów z wikipedii.

Dane w formacie CSV można pobrać z linku: [Dane](https://drive.google.com/open?id=1C69iSzouKrIZNA-m0TwJnDY1Hs6K86-8).

Mniejsza próbka danych (100 tys. rekordów) znajduje się pod tym [linkiem](https://drive.google.com/file/d/1y8aR5f2grL3kfurC-VD03TzdJW845C4Y/view?usp=sharing).

## Wstępne wymagania

Na komputerze musi działać serwer MongoDB włączany komendą <code>mongod</code>. Włączamy bez dodatkowych opcji.

## Kompilacja

Skrypty kompilujemy wykorzystując kompilator c#, czyli csc. Do kompilacji dodajemy referencje do sterowników MongoDB. Przykład:

<code>
csc /r:"MongoDB.Driver.dll" /r:"MongoDB.Bson.dll" InsertOne.cs
</code>

W wyniku kompilacji pojawia się plik wykonywalny, który włączamy z linii poleceń podając ewentualne argumenty.
