import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/licensePlate.dart';
import 'databaseInfor.dart';

class LicensePlateDB {

  static const _licensePlateTable = 'LicensePlate';
  static const _columnID = 'LicensePlate_ID';
  static const _columnName = 'name';
  static const _columnProvinceID = 'Province_ID';

  // Create table
  static Future<void> createTableLicensePlate(Database database) async {
    try {
      await database.execute('''
          CREATE TABLE $_licensePlateTable (
          $_columnID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $_columnName TEXT,
          $_columnProvinceID INTEGER,
          FOREIGN KEY($_columnProvinceID) REFERENCES Province($_columnID)
          )''');
    } catch (err) {
      debugPrint("createTableLicensePlate(): $err");
    }
  }

  // Insert new license plate
  static Future<int> insertLicensePlate(LicensePlate licensePlate) async {
    int id = 0;
    try {
      final db = await DatabaseInfor.getDb();
      id = await db.insert(_licensePlateTable, licensePlate.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("insertLicensePlate(): $err");
    }
    return id;
  }

  // Read all license plates
  static Future<List<Map<String, dynamic>>> getLicensePlates(int id) async {
    late Future<List<Map<String, dynamic>>> licensePlateList;
    try {
      final db = await DatabaseInfor.getDb();
      licensePlateList = db.query(_licensePlateTable, where: "Province_ID = ?", whereArgs: [id], orderBy: _columnID);
    } catch (err) {
      debugPrint("getLicensePlates(): $err");
    }
    return licensePlateList;
  }

  // Read a single license plate by id
  static Future<List<Map<String, dynamic>>> getLicensePlate(int id) async {
    late Future<List<Map<String, dynamic>>> licensePlate;
    try {
      final db = await DatabaseInfor.getDb();
      licensePlate = db.query(
          _licensePlateTable, where: "$_columnID = ?", whereArgs: [id], limit: 1);
    } catch (err) {
      debugPrint("getLicensePlate(): $err");
    }
    return licensePlate;
  }

  // Update a license plate by id
  static Future<int> updateLicensePlate(LicensePlate licensePlate) async {
    int result = 0;
    try {
      final db = await DatabaseInfor.getDb();
      result = await db.update(_licensePlateTable, licensePlate.toMap(),
          where: "$_columnID = ?", whereArgs: [licensePlate.licensePlate_ID]);
    } catch (err) {
      debugPrint("updateLicensePlate(): $err");
    }
    return result;
  }

  // Delete a license plate by id
  static Future<void> deleteLicensePlate(int id) async {
    try {
      final db = await DatabaseInfor.getDb();
      await db.delete(_licensePlateTable, where: "$_columnID = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("deleteLicensePlate(): $err");
    }
  }

}
