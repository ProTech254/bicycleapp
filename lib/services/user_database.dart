
import 'package:bicycleapp/app_screens/homepage.dart';
import 'package:bicycleapp/app_screens/login.dart';
import 'package:bicycleapp/models/bicycle_data.dart';
import 'package:bicycleapp/models/cart_data.dart';
import 'package:bicycleapp/models/orders_data.dart';
import 'package:bicycleapp/models/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
// import 'package:flutter_session/flutter_session.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase{
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;
  UserDatabase._init();

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB('bicycle.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path  = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);

  }

  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    // create users table
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableUsers(
      ${UsersFields.id} $idType,
      ${UsersFields.fullnames} $textType,
      ${UsersFields.email_address} $textType,
      ${UsersFields.phone_number} $textType,
      ${UsersFields.password} $textType,
      ${UsersFields.user_role} $textType
    )
    ''');

    //create cart table
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableCart(
      ${CartFields.id} $idType,
      ${CartFields.name} $textType,
      ${CartFields.amount} $textType,
      ${CartFields.picture} $textType
     
    )
    ''');

    //create bicycles table
    await db.execute('''
   CREATE TABLE IF NOT EXISTS $tableBicycles(
      ${BicyclesFields.id} $idType,
      ${BicyclesFields.name} $textType,
      ${BicyclesFields.description} $textType,
      ${BicyclesFields.amount} $textType,
      ${BicyclesFields.picture} $textType,
      ${BicyclesFields.category} $textType
     
    )
    ''');
    //orders table

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableOrders(
      ${OrdersFields.id} $idType,
      ${OrdersFields.name} $textType,
      ${OrdersFields.amount} $textType,
      ${OrdersFields.picture} $textType
     
    )
    ''');


  }
  // Create a user table
  Future<Users> create(Users users) async {
    final db = await instance.database;
    print(users.phone_number);
    final id = await db.insert(tableUsers, users.toJson());
    // await FlutterSession().set("user_id ", "$id");
    print('created user');
    return users.copy(id:id);
  }

  Future<Users> readLoginData(String email, String password, BuildContext context) async{
    final db = await instance.database;
    // final maps = await db.query(
    //   tableTeachers,
    //   columns: TeacherFields.values,
    //   where: '${TeacherFields.id} = ?',
    //   whereArgs: [id],
    // );
    var res = await db.rawQuery("SELECT * FROM users WHERE email_address = '$email' and password = '$password'");
    if (res.isNotEmpty){

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('email', email);

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => BicycleList()));
      Fluttertoast.showToast(msg: "Login Succes");
      return Users.fromJson(res.first);
    }else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
      Fluttertoast.showToast(msg: "Email $email not found");
      throw Exception('ID $email not found');
    }
  }


  Future close() async {
    final db = await instance.database;
    db.close();
  }
}