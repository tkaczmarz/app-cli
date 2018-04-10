# Tomasz Kaczmarz - Projekt na zaliczenie

W projekcie korzystam z [bazy danych](https://www.kaggle.com/residentmario/wikipedia-article-titles) zawierającej wszystkie tytuły artykułów z wikipedii.

Dane w formacie CSV można pobrać z linku: [Dane](https://drive.google.com/open?id=1C69iSzouKrIZNA-m0TwJnDY1Hs6K86-8).

Mniejsza próbka danych (100 tys. rekordów) znajduje się pod tym [linkiem](https://drive.google.com/file/d/1y8aR5f2grL3kfurC-VD03TzdJW845C4Y/view?usp=sharing).

Przykładowy JSON z bazy:
```
{
	title: "!Amigos!"
}
```

## Wstępne wymagania

Na komputerze musi działać serwer MongoDB włączany komendą <code>mongod</code>. Włączamy bez dodatkowych opcji.
Po uruchomieniu serwera używamy skrytu import.sh. 
Skrypt wymaga pliku z danymi o nazwie 'titles.csv' w tym samym katalogu.
Po wykonaniu skryptu mamy już działającą bazę danych, na której możemy pracować.

## Kompilacja

Skrypty kompilujemy wykorzystując kompilator c#, czyli csc. Do kompilacji dodajemy referencje do sterowników MongoDB. Przykład:

<code>
csc /r:"MongoDB.Driver.dll" /r:"MongoDB.Bson.dll" InsertOne.cs
</code>

W wyniku kompilacji pojawia się plik wykonywalny, który włączamy z linii poleceń podając ewentualne argumenty.


## Użytkowanie

- InsertOne
<p>
  Skrypt możemy włączyć bez parametrów i po uruchomieniu zostaniemy zapytani o dane (tytuł artykułu).
  Drugim sposobem jest podanie danych w argumencie programu.
  Po uzyskaniu napisu skrypt dodaje wpis do bazy danych.
</p>

- Find
<p>
  Skrypt włączony bez argumentów liczy wszystkie rekordy w bazie danych.
  Po podaniu parametru wyszukuje danego tytułu w bazie.
</p>
