// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'item.dart' as TodoItem;
//
// class DatabaseHelper { //database_helper.dart
//   static const String dbName = 'item_test.db';
//
//   static DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();
//
//   DatabaseHelper._createInstance(); //Dart에서 _로 시작하는 것은 private를 의미합니다.
//
//   factory DatabaseHelper() {
//     return _databaseHelper;
//   }
//
//   final Future<Database> database = openDatabase();
//
//   static Future<Database> openDatabase() async {
//     print('openDatabase');
//     // return database ??= await databaseFactory.openDatabase(dbName);
//     return databaseFactory.openDatabase(dbName,
//         options: OpenDatabaseOptions(
//             version: 1,
//             onCreate: (db, version) async {
//               await db.execute('CREATE TABLE Item (seq INTEGER ,title TEXT)');
//             }));
//   }
//
//   Future closeDatabase() async {
//     Database database = await this.database;
//     database.close();
//   }
//
//   //Read All
//   Future<List<TodoItem.Item>> getItems() async {
//     var db = await this.database;
//     var res = await db.rawQuery('SELECT * FROM Item');
//     // List<Map<String, Object?>> res = db.rawQuery('SELECT * FROM Item');
//     List<TodoItem.Item> list = res.isNotEmpty ? res.map((c) => TodoItem.Item(seq:c['seq'] as int , title:c['title'] as String)).toList() : [];
//     print(list);
//     return list;
//   }
//
//   Future insertRow(String title) async {
//     var db = await this.database;
//     await db.insert('Item', {'seq':0, 'title': title});
//   }
//   Future _deleteDatabase() async {
//     await databaseFactory.deleteDatabase(dbName);
//   }
// }