import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class UserDatabaseManager {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT ,
        name TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'database1.db', // Renamed database file to 'user_data.db'
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
      version: 1,
    );
  }

  static Future<int> createUser(String username, String? name) async {
    final db = await UserDatabaseManager.db();
    final data = {"username": username, "name": name};

    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await UserDatabaseManager.db();
    return db.query('users', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getUserByUsername(
      String username) async {
    final db = await UserDatabaseManager.db();
    return db.query('users', where: "username = ?", whereArgs: [username], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getUserById(int id) async {
    final db = await UserDatabaseManager.db();
    return db.query('users', where: "id = ?", whereArgs: [id], limit: 1);
  }

// static Future<int> updateUser(int id, String username, String name) async {
//   final db = await UserDatabaseManager.db();
//
//   final data = {
//     'username': username,
//     'name': name,
//     'createdate': DateTime.now().toString()
//   };
//
//   final result =
//   await db.update('users', data, where: "id = ?", whereArgs: [id]);
//   return result;
// }

// static Future<void> deleteUser(int id) async {
//   final db = await UserDatabaseManager.db();
//   try {
//     await db.delete("users", where: "id = ?", whereArgs: [id]);
//   } catch (err) {
//     debugPrint("Something went wrong");
//   }
// }
}
