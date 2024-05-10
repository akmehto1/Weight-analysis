import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;


class UserWeightDatabaseManager {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
      CREATE TABLE user_weights(
       id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        weight REAL,
        month INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'user_weight_data.db',
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
      version: 1,
    );
  }

  static Future<int> addUserWeight(String username, double? weight, String month) async {
    final db = await UserWeightDatabaseManager.db();
    final monthIndex = DateFormat('MMMM').parse(month).month - 1; // January starts from 0
    final data = {"username": username, "weight": weight, "month": monthIndex};

    final id = await db.insert('user_weights', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<Map<String, dynamic>?> getLastUserWeightByUsername(String username) async {
    final db = await UserWeightDatabaseManager.db();
    final result = await db.query(
      'user_weights',
      where: "username = ?",
      whereArgs: [username],
      orderBy: "createdAt DESC",
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  static Future<List<Map<String, dynamic>>> getUserWeights() async {
    final db = await UserWeightDatabaseManager.db();
    return db.query('user_weights', orderBy: "createdAt");
  }

  static Future<List<Map<String, dynamic>>> getUserWeightByUsername(
      String username) async {
    final db = await UserWeightDatabaseManager.db();
    return db.query('user_weights',
        where: "username = ?", whereArgs: [username], orderBy: "month");
  }

  static Future<int> updateUserWeight(int id, String username, double? newWeight) async {
    final db = await UserWeightDatabaseManager.db();

    final data = {'weight': newWeight, 'createdAt': DateTime.now().toString()};

    final result = await db.update('user_weights', data,
        where: "id = ? AND username = ?", whereArgs: [id, username]);
    return result;
  }

  static Future<List<String>> getDistinctUserNames() async {
    final db = await UserWeightDatabaseManager.db();
    final result = await db.rawQuery('SELECT DISTINCT username FROM user_weights');
    final usernames = result.map<String>((row) => row['username'] as String).toList();
    return usernames;
  }


  static Future<void> deleteUserWeight(String username) async {
    final db = await UserWeightDatabaseManager.db();
    try {
      await db.delete("user_weights", where: "username = ?", whereArgs: [username]);
    } catch (err) {
      debugPrint("Something went wrong");
    }
  }
}
