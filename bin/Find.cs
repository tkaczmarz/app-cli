using MongoDB.Bson;
using MongoDB.Driver;
using MongoDB.Driver.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

/*
Skrypt służy przeszukiwania bazy danych.

Użytkowanie:
1) Po uruchomieniu bez argumentów program podaje liczbę rekordów w bazie.
2) W przypadku podania argumentu program wyszukuje elementów o danym tytule w bazie.
 */

namespace WikiTitles
{
    class Find
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Connecting to database...");

            var client = new MongoClient("mongodb://localhost:27017");
            var db = client.GetDatabase("wiki");
            var collection = db.GetCollection<BsonDocument>("titles");

            Console.WriteLine("Connection established!");

            if (args.Length == 0)
            {
                var count = collection.Count(new BsonDocument());
                Console.WriteLine("Collection has " + count + " documents.");
            }
            else if (args.Length > 0)
            {
                var filter = Builders<BsonDocument>.Filter.Eq("title", args[0]);
                var cursor = collection.Find(filter).ToCursor();
                int counter = 0;
                Console.WriteLine("Found:");
                foreach (var doc in cursor.ToEnumerable())
                {
                    Console.WriteLine(doc);
                    counter++;
                }
                Console.WriteLine(counter + " occurrence(s)");
            }
        }
    }
}
