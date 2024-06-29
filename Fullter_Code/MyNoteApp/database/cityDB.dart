import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/city.dart';
import 'databaseInfor.dart';

class CityDB {

  static const _cityTable = 'City';
  static const _columnID = 'City_ID';
  static const _columnName = 'name';
  static const _columnProvinceID = 'Province_ID';

  // Create table
  static Future<void> createTableCity(Database database) async {
    try {
      await database.execute('''
          CREATE TABLE $_cityTable (
          $_columnID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          $_columnName TEXT,
          $_columnProvinceID INTEGER,
          FOREIGN KEY($_columnProvinceID) REFERENCES Province($_columnID)
          )''');
    } catch (err) {
      debugPrint("createTableCity(): $err");
    }
  }

  // Insert new city
  static Future<int> insertCity(City city) async {
    int id = 0;
    try {
      final db = await DatabaseInfor.getDb();
      id = await db.insert(_cityTable, city.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      debugPrint("insertCity(): $err");
    }
    return id;
  }

  // Read all cities
  static Future<List<Map<String, dynamic>>> getCities(int id) async {
    late Future<List<Map<String, dynamic>>> cityList;
    try {
      final db = await DatabaseInfor.getDb();
      cityList = db.query(_cityTable, where: "Province_ID = ?", whereArgs: [id], orderBy: _columnID);
    } catch (err) {
      debugPrint("getCities(): $err");
    }
    return cityList;
  }

  // Read a single city by id
  static Future<List<Map<String, dynamic>>> getCity(int id) async {
    late Future<List<Map<String, dynamic>>> city;
    try {
      final db = await DatabaseInfor.getDb();
      city = db.query(
          _cityTable, where: "$_columnID = ?", whereArgs: [id], limit: 1);
    } catch (err) {
      debugPrint("getCity(): $err");
    }
    return city;
  }

  // Update a city by id
  static Future<int> updateCity(City city) async {
    int result = 0;
    try {
      final db = await DatabaseInfor.getDb();
      result = await db.update(_cityTable, city.toMap(),
          where: "$_columnID = ?", whereArgs: [city.city_ID]);
    } catch (err) {
      debugPrint("updateCity(): $err");
    }
    return result;
  }

  // Delete a city by id
  static Future<void> deleteCity(int id) async {
    try {
      final db = await DatabaseInfor.getDb();
      await db.delete(_cityTable, where: "$_columnID = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("deleteCity(): $err");
    }
  }

}
