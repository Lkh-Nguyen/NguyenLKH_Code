import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/scenicSpot.dart';
import 'databaseInfor.dart';

class ScenicSpotDB {

  static const _scenicSpotTable = 'ScenicSpot';
  static const _columnID = 'ScenicSpot_ID';
  static const _columnName = 'name';
  static const _columnProvinceID = 'Province_ID';

  // Create table
  static Future<void> createTableScenicSpot(Database database) async {
    try {
      await database.execute('''
          CREATE TABLE $_scenicSpotTable (
          $_columnID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $_columnName TEXT,
          $_columnProvinceID INTEGER,
          FOREIGN KEY($_columnProvinceID) REFERENCES Province($_columnID)
          )''');
    } catch (err) {
      debugPrint("createTableScenicSpot(): $err");
    }
  }

  // Insert new scenic spot
  static Future<int> insertScenicSpot(ScenicSpot scenicSpot) async {
    int id = 0;
    try {
      final db = await DatabaseInfor.getDb();
      id = await db.insert(_scenicSpotTable, scenicSpot.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("insertScenicSpot(): $err");
    }
    return id;
  }

  // Read all scenic spots
  static Future<List<Map<String, dynamic>>> getScenicSpots(int id) async {
    late Future<List<Map<String, dynamic>>> scenicSpotList;
    try {
      final db = await DatabaseInfor.getDb();
      scenicSpotList = db.query(_scenicSpotTable, where: "Province_ID = ?", whereArgs: [id], orderBy: _columnID);
    } catch (err) {
      debugPrint("getScenicSpots(): $err");
    }
    return scenicSpotList;
  }

  // Read a single scenic spot by id
  static Future<List<Map<String, dynamic>>> getScenicSpot(int id) async {
    late Future<List<Map<String, dynamic>>> scenicSpot;
    try {
      final db = await DatabaseInfor.getDb();
      scenicSpot = db.query(
          _scenicSpotTable, where: "$_columnID = ?", whereArgs: [id], limit: 1);
    } catch (err) {
      debugPrint("getScenicSpot(): $err");
    }
    return scenicSpot;
  }

  // Update a scenic spot by id
  static Future<int> updateScenicSpot(ScenicSpot scenicSpot) async {
    int result = 0;
    try {
      final db = await DatabaseInfor.getDb();
      result = await db.update(_scenicSpotTable, scenicSpot.toMap(),
          where: "$_columnID = ?", whereArgs: [scenicSpot.scenicSpot_ID]);
    } catch (err) {
      debugPrint("updateScenicSpot(): $err");
    }
    return result;
  }

  // Delete a scenic spot by id
  static Future<void> deleteScenicSpot(int id) async {
    try {
      final db = await DatabaseInfor.getDb();
      await db.delete(_scenicSpotTable, where: "$_columnID = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("deleteScenicSpot(): $err");
    }
  }

}
