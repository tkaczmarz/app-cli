using MongoDB.Bson;
using MongoDB.Driver;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*
Skrypt służy do dodawania danych do bazy danych.

Użytkowanie:
1) Po uruchomieniu program pyta o dane i po podaniu wstawia je do bazy.
2) Dane podajemy od razu w argumencie (pierwszy parametr) i program natychmiast wrzuca je do bazy.
 */

namespace WikiTitles
{
    class InsertOne
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Connecting to database...");

            var client = new MongoClient("mongodb://localhost:27017");
            var db = client.GetDatabase("wiki");
            var collection = db.GetCollection<BsonDocument>("titles");

            Console.WriteLine("Connection established!");

            string title;
            if (args.Length > 0 && args[0].Length > 0)
            {
                Console.WriteLine("Adding '" + args[0] + "'");
                title = args[0];
            }
            else
            {
                Console.WriteLine("Type in title to add.");
                title = Console.ReadLine();
                Console.WriteLine("Adding '" + title + "'");
            }

            var doc = new BsonDocument
            {
                { "title", title }
            };
            collection.InsertOne(doc);
        }
    }
}
