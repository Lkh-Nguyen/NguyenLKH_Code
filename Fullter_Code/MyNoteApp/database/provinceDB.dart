import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/province.dart';
import 'databaseInfor.dart';


class ProvinceDB {

  static const _userTables = 'Province';

  static const _columnID = 'Province_ID';
  static const _columnName = 'name';

// id: the id ofa item
// title, description: name and description of your activity
// created at: the time that the item was created.
// It will be automatically handled by SQLite

  static Future<void> createTableProvince(Database database) async {
    try {
      await database.execute('''
      CREATE TABLE $_userTables (
        $_columnID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $_columnName TEXT
      )
    ''');
    } catch (err) {
      debugPrint("createTableProvince(): $err");
    }
  }

  //create new customer

  static Future<int> insertProvince(Pronvince pronvince) async {
    int id = 0;
    try {
      final db = await DatabaseInfor.getDb();
      // Sometimes you want to insert an empty row, in that case ContentVaIues
      // have no content value, and you should use nullColumnHack.
      // For example, you want to insert an empty row into a table student(id, name),
      // which id is auto generated and name is null.
      id = await db.insert(_userTables, pronvince.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("insertCustomer(): $err");
    }
    return id;
  }



  // Read all items
  static Future<List<Map<String, dynamic>>> getProvinces() async {
    late Future<List<Map<String, dynamic>>> provinceList;
    try {
      final db = await DatabaseInfor.getDb();
      provinceList = db.query(_userTables, orderBy: _columnID);
    } catch (err) {
      debugPrint("GetCustomers(): $err");
    }
    return provinceList;
  }
  static Future<List<Map<String, dynamic>>> getProvincesOrderby(bool ascending) async {
    late Future<List<Map<String, dynamic>>> provinceList;
    try {
      final db = await DatabaseInfor.getDb();
      provinceList = db.query(
        _userTables,
        orderBy: _columnID + (ascending ? ' ASC' : ' DESC'),
      );
    } catch (err) {
      debugPrint("getProvinces(): $err");
      // Handle error as needed
      provinceList = Future.value([]);
    }
    return provinceList;
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getProvince(int id) async {
    late Future<List<Map<String, dynamic>>> province;
    try {
      final db = await DatabaseInfor.getDb();
      province = db.query(
          _userTables, where: "$_columnID = ?", whereArgs: [id], limit: 1);
    } catch (err) {
      debugPrint("getCustomer(): $err");
    }
    return province;
  }

  // Update an item by id
  static Future<int> updateProvince(Pronvince province) async {
    int result = 0;
    try {
      final db = await DatabaseInfor.getDb();
      result = await db.update(_userTables, province.toMap(),
          where: "$_columnID = ?", whereArgs: [province.Province_ID]);
    } catch (err) {
      debugPrint("updateItem(): $err");
    }
    return result;
  }

  // Delete a single item by id
  static Future<void> deleteProvince(int id) async {
    try {
      final db = await DatabaseInfor.getDb();
      await db.delete(_userTables, where: "$_columnID = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

}
