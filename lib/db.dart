import 'package:flutter_task1/constant.dart';
import 'package:sqflite/sqflite.dart';
import 'registration.dart';
import 'package:path/path.dart';

class MyDataBase {
  static Database? db;

  Future<Database?> initializedDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    db = await openDatabase(
      join(databasesPath, Constants.DB_NAME),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE ${Constants.REG_TABLE_NAME}(id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT NOT NULL,first_name TEXT NOT NULL ,middle_name TEXT  NOT NULL,last_name TEXT NOT NULL ,mobile_number TEXT  NOT NULL ,email_id TEXT NOT NULL,password TEXT NOT NULL, gender TEXT NOT NULL,dob_birth TEXT NOT NULL ,age TEXT NOT NULL)",
        );
      },
    );

    return db;
  }

// insert data
  Future<int> insertRegistrationDetails(RegistrationModel regDetails) async {
    int result = 0;
    final Database? db = await initializedDB();
    // for (var planet in regDetails) {
    result = await db!.insert(Constants.REG_TABLE_NAME, regDetails.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    // }

    return result;
  }

// delete user
  Future<void> deleteRegistration(int id) async {
    final db = await initializedDB();
    await db!.delete(
      Constants.REG_TABLE_NAME,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getRegistrationData(
      String username, String password) async {
    print(username);
    print(password);
    final db = await initializedDB();
    var res = await db!.query(
      Constants.REG_TABLE_NAME,
      where: "email_id = ? AND password = ?",
      whereArgs: [username, password],
    );

    print(res);

    return res;
  }
}
