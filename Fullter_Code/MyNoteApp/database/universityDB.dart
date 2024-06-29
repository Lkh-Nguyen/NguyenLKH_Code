import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/university.dart';
import 'databaseInfor.dart';

class UniversityDB {

  static const _universityTable = 'University';
  static const _columnID = 'university_id';
  static const _columnName = 'name';
  static const _columnProvinceID = 'Province_ID';

  // Create table
  static Future<void> createTableUniversity(Database database) async {
    try {
      await database.execute('''
          CREATE TABLE $_universityTable (
          $_columnID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $_columnName TEXT,
          $_columnProvinceID INTEGER,
          FOREIGN KEY($_columnProvinceID) REFERENCES Province($_columnID)
          )''');
    } catch (err) {
      debugPrint("createTableUniversity(): $err");
    }
  }

  // Insert new university
  static Future<int> insertUniversity(University university) async {
    int id = 0;
    try {
      final db = await DatabaseInfor.getDb();
      id = await db.insert(_universityTable, university.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("insertUniversity(): $err");
    }
    return id;
  }

  // Read all universities
  static Future<List<Map<String, dynamic>>> getUniversities(int id) async {
    late Future<List<Map<String, dynamic>>> universityList;
    try {
      final db = await DatabaseInfor.getDb();
      universityList = db.query(_universityTable, where: "Province_ID = ?", whereArgs: [id], orderBy: _columnID);
    } catch (err) {
      debugPrint("getUniversities(): $err");
    }
    return universityList;
  }

  // Read a single university by id
  static Future<List<Map<String, dynamic>>> getUniversity(int id) async {
    late Future<List<Map<String, dynamic>>> university;
    try {
      final db = await DatabaseInfor.getDb();
      university = db.query(
          _universityTable, where: "$_columnID = ?", whereArgs: [id], limit: 1);
    } catch (err) {
      debugPrint("getUniversity(): $err");
    }
    return university;
  }

  // Update a university by id
  static Future<int> updateUniversity(University university) async {
    int result = 0;
    try {
      final db = await DatabaseInfor.getDb();
      result = await db.update(_universityTable, university.toMap(),
          where: "$_columnID = ?", whereArgs: [university.university_id]);
    } catch (err) {
      debugPrint("updateUniversity(): $err");
    }
    return result;
  }

  // Delete a university by id
  static Future<void> deleteUniversity(int id) async {
    try {
      final db = await DatabaseInfor.getDb();
      await db.delete(_universityTable, where: "$_columnID = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("deleteUniversity(): $err");
    }
  }

}
