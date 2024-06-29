import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/specialty.dart';
import 'databaseInfor.dart';

class SpecialtyDB {

  static const _specialtyTable = 'Specialty';
  static const _columnID = 'specialty_ID';
  static const _columnName = 'name';
  static const _columnProvinceID = 'Province_ID';

  // Create table
  static Future<void> createTableSpecialty(Database database) async {
    try {
      await database.execute('''
          CREATE TABLE $_specialtyTable (
          $_columnID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $_columnName TEXT,
          $_columnProvinceID INTEGER,
          FOREIGN KEY($_columnProvinceID) REFERENCES Province($_columnID)
          )''');
    } catch (err) {
      debugPrint("createTableSpecialty(): $err");
    }
  }

  // Insert new specialty
  static Future<int> insertSpecialty(Specialty specialty) async {
    int id = 0;
    try {
      final db = await DatabaseInfor.getDb();
      id = await db.insert(_specialtyTable, specialty.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("insertSpecialty(): $err");
    }
    return id;
  }

  // Read all specialties
  static Future<List<Map<String, dynamic>>> getSpecialties(int id) async {
    late Future<List<Map<String, dynamic>>> specialtyList;
    try {
      final db = await DatabaseInfor.getDb();
      specialtyList = db.query(_specialtyTable, where: "Province_ID = ?", whereArgs: [id], orderBy: _columnID);
    } catch (err) {
      debugPrint("getSpecialties(): $err");
    }
    return specialtyList;
  }

  // Read a single specialty by id
  static Future<List<Map<String, dynamic>>> getSpecialty(int id) async {
    late Future<List<Map<String, dynamic>>> specialty;
    try {
      final db = await DatabaseInfor.getDb();
      specialty = db.query(
          _specialtyTable, where: "$_columnID = ?", whereArgs: [id], limit: 1);
    } catch (err) {
      debugPrint("getSpecialty(): $err");
    }
    return specialty;
  }

  // Update a specialty by id
  static Future<int> updateSpecialty(Specialty specialty) async {
    int result = 0;
    try {
      final db = await DatabaseInfor.getDb();
      result = await db.update(_specialtyTable, specialty.toMap(),
          where: "$_columnID = ?", whereArgs: [specialty.specialty_ID]);
    } catch (err) {
      debugPrint("updateSpecialty(): $err");
    }
    return result;
  }

  // Delete a specialty by id
  static Future<void> deleteSpecialty(int id) async {
    try {
      final db = await DatabaseInfor.getDb();
      await db.delete(_specialtyTable, where: "$_columnID = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("deleteSpecialty(): $err");
    }
  }

}
