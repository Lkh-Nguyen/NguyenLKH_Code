import 'package:sqflite/sqflite.dart';
import 'package:untitled2/MyNoteApp/database/cityDB.dart';
import 'package:untitled2/MyNoteApp/database/licensePlateDB.dart';
import 'package:untitled2/MyNoteApp/database/provinceDB.dart';
import 'package:untitled2/MyNoteApp/database/scenicSpotDB.dart';
import 'package:untitled2/MyNoteApp/database/specialtyDB.dart';
import 'package:untitled2/MyNoteApp/database/universityDB.dart';
import 'package:untitled2/MyNoteApp/database/userDB.dart';




class DatabaseInfor{
  static const _databaseName = "MyListProvince.db";
  static const _databaseVersion = 1;


  static Future<Database> getDb() async {
    return openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: (Database database, int version) async {
        await UserDB.createTableUser(database);
        await ProvinceDB.createTableProvince(database);
        await CityDB.createTableCity(database);
        await ScenicSpotDB.createTableScenicSpot(database);
        await SpecialtyDB.createTableSpecialty(database);
        await UniversityDB.createTableUniversity(database);
        await LicensePlateDB.createTableLicensePlate(database);

      },
    );
  }

// static Future<Database> getDb() async {
//   return openDatabase(
//     _databaseName,
//     version: _databaseVersion,
//     onCreate: (Database database, int version) async {
//       await CustomerDB.createTableCustomer(database);
//     },
//     onUpgrade: (Database database, int oldVersion, int newVersion) async {
//         await ItemDB.createItemTable(database);
//       // Add more upgrade logic for other versions if needed
//     },
//   );
// }

}



// await UserDB.insertUser(User(
//   email : 'le1@gm.com',
//   password: '12345678',
//   gender: 'Male',
// ));
// await UserDB.insertUser(User(
//   email : 'le2@gm.com',
//   password: '12345678',
//   gender: 'Female',
// ));
// //Insert Province Hà Nội
// await ProvinceDB.insertProvince(Pronvince(
//   name: 'Hà Nội',
// ));
// await CityDB.insertCity(City(
//   name: 'Ba Đình',
//   Province_ID: 1,
// ));
// await CityDB.insertCity(City(
//   name: 'Hoàn Kiếm',
//   Province_ID: 1,
// ));
//
// await ScenicSpotDB.insertScenicSpot(ScenicSpot(
//   name: 'Hoàn Kiếm Lake',
//   Province_ID: 1,
// ));
// await ScenicSpotDB.insertScenicSpot(ScenicSpot(
//   name: 'Tháp Rùa',
//   Province_ID: 1,
// ));
//
// await SpecialtyDB.insertSpecialty(Specialty(
//   name: 'Phở',
//   Province_ID: 1,
// ));
// await SpecialtyDB.insertSpecialty(Specialty(
//   name: 'Chả cá Lã Vọng',
//   Province_ID: 1,
// ));
//
// await UniversityDB.insertUniversity(University(
//   name: 'Đại học Quốc gia Hà Nội',
//   Province_ID: 1,
// ));
// await UniversityDB.insertUniversity(University(
//   name: 'Đại học Bách khoa Hà Nội',
//   Province_ID: 1,
// ));
// //Insert Province Hồ Chí Minh
// await ProvinceDB.insertProvince(Pronvince(
//   name: 'Hồ Chí Minh',
// ));
//
// await CityDB.insertCity(City(
//   name: 'Phú Nhuận',
//   Province_ID: 2,
// ));
// await CityDB.insertCity(City(
//   name: 'Thủ Đức',
//   Province_ID: 2,
// ));
//
// await ScenicSpotDB.insertScenicSpot(ScenicSpot(
//   name: 'Bến Nhà Rồng',
//   Province_ID: 2,
// ));
// await ScenicSpotDB.insertScenicSpot(ScenicSpot(
//   name: 'Bảo tàng Hồ Chí Minh',
//   Province_ID: 2,
// ));
// await SpecialtyDB.insertSpecialty(Specialty(
//   name: 'Bánh mì',
//   Province_ID: 2,
// ));
// await SpecialtyDB.insertSpecialty(Specialty(
//   name: 'Bánh xèo',
//   Province_ID: 2,
// ));
// await UniversityDB.insertUniversity(University(
//   name: 'Đại học Quốc gia TP.HCM',
//   Province_ID: 2,
// ));
// await UniversityDB.insertUniversity(University(
//   name: 'Đại học Kinh tế TP.HCM',
//   Province_ID: 2,
// ));
// await LicensePlateDB.insertLicensePlate(LicensePlate(
//   name: '59',
//   Province_ID: 2,
// ));
// await LicensePlateDB.insertLicensePlate(LicensePlate(
//   name: '41',
//   Province_ID: 2,
// ));
// // Insert license plates
// await LicensePlateDB.insertLicensePlate(LicensePlate(
//   name: '29',
//   Province_ID: 1,
// ));
// await LicensePlateDB.insertLicensePlate(LicensePlate(
//   name: '30',
//   Province_ID: 1,
// ));
// //Insert Province Đà Nẵng
// await ProvinceDB.insertProvince(Pronvince(
//   name: 'Đà Nẵng',
// ));
// await CityDB.insertCity(City(
//   name: 'Hải Châu',
//   Province_ID: 3,
// ));
// await CityDB.insertCity(City(
//   name: 'Thanh Khê',
//   Province_ID: 3,
// ));
// await ScenicSpotDB.insertScenicSpot(ScenicSpot(
//   name: 'Bà Nà Hills',
//   Province_ID: 3,
// ));
// await ScenicSpotDB.insertScenicSpot(ScenicSpot(
//   name: 'Cầu Rồng',
//   Province_ID: 3,
// ));
// await SpecialtyDB.insertSpecialty(Specialty(
//   name: 'Mì Quảng',
//   Province_ID: 3,
// ));
// await SpecialtyDB.insertSpecialty(Specialty(
//   name: 'Bún chả cá',
//   Province_ID: 3,
// ));
// await UniversityDB.insertUniversity(University(
//   name: 'Đại học Đà Nẵng',
//   Province_ID: 3,
// ));
// await UniversityDB.insertUniversity(University(
//   name: 'Đại học Duy Tân',
//   Province_ID: 3,
// ));
// await LicensePlateDB.insertLicensePlate(LicensePlate(
//   name: '43',
//   Province_ID: 3,
// ));