import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';
import 'databaseInfor.dart';


class UserDB {

  static const _userTables = 'User';

  static const _columnID = 'id';
  static const _columnEmail = 'email';
  static const _columnPassword = 'password';
  static const _columnGender = 'gender';

// id: the id ofa item
// title, description: name and description of your activity
// created at: the time that the item was created.
// It will be automatically handled by SQLite

  static Future<void> createTableUser(Database database) async {
    try {
      await database.execute('''
          CREATE TABLE $_userTables (
          $_columnID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $_columnEmail TEXT,
          $_columnPassword TEXT,
          $_columnGender TEXT
          )''');
    } catch (err) {
      debugPrint("createTable(): $err");
    }
  }

  //create new customer

  static Future<int> insertUser(User user) async {
    int id = 0;
    try {
      final db = await DatabaseInfor.getDb();
      // Sometimes you want to insert an empty row, in that case ContentVaIues
      // have no content value, and you should use nullColumnHack.
      // For example, you want to insert an empty row into a table student(id, name),
      // which id is auto generated and name is null.
      id = await db.insert(_userTables, user.toMapUser(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("insertCustomer(): $err");
    }
    return id;
  }



  // Read all items
  static Future<List<Map<String, dynamic>>> getUsers() async {
    late Future<List<Map<String, dynamic>>> userList;
    try {
      final db = await DatabaseInfor.getDb();
      userList = db.query(_userTables, orderBy: _columnID);
    } catch (err) {
      debugPrint("GetCustomers(): $err");
    }
    return userList;
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getUser(String email) async {
    late Future<List<Map<String, dynamic>>> user;
    try {
      final db = await DatabaseInfor.getDb();
      user = db.query(
          _userTables, where: "$_columnEmail = ?", whereArgs: [email], limit: 1);
    } catch (err) {
      debugPrint("getCustomer(): $err");
    }
    return user;
  }

  // Update an item by id
  static Future<int> updateCustomer(User user) async {
    int result = 0;
    try {
      final db = await DatabaseInfor.getDb();
      result = await db.update(_userTables, user.toMapUser(),
          where: "$_columnID = ?", whereArgs: [user.id]);
    } catch (err) {
      debugPrint("updateItem(): $err");
    }
    return result;
  }

  // Delete a single item by id
  static Future<void> deleteCustomer(int id) async {
    try {
      final db = await DatabaseInfor.getDb();
      await db.delete(_userTables, where: "$_columnID = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

}
