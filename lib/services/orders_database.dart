
import 'package:bicycleapp/models/bicycle_data.dart';

import 'package:bicycleapp/models/orders_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OrdersDatabase{
  static final OrdersDatabase instance = OrdersDatabase._init();

  static Database? _database;
  OrdersDatabase._init();

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


    await db.execute('''
    CREATE TABLE IF NOT EXISTS$tableOrders(
      ${OrdersFields.id} $idType,
      ${OrdersFields.name} $textType,
      ${OrdersFields.amount} $textType
      ${OrdersFields.picture} $textType
     
    )
    ''');



    // await db.execute('''
    // CREATE TABLE $tableTeachers(
    //   ${TeacherFields.id} $idType,
    //   ${TeacherFields.username} $textType,
    //   ${TeacherFields.email} $textType,
    //   ${TeacherFields.phone_number} $textType,
    //   ${TeacherFields.password} $textType,
    // )
    // ''');
  }

  Future<Orders> create(Orders orders) async {
    final db = await instance.database;
    final id = await db.insert(tableOrders, orders.toJson());
    return orders.copy(id:id);
  }

  //Read bicycle data according to ID
  Future<Orders> readData(int id) async{
    final db = await instance.database;
    final maps = await db.query(
      tableOrders,
      columns: OrdersFields.values,
      where: '${OrdersFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty){
      return Orders.fromJson(maps.first);
    }else{
      throw Exception('Bicycle with ID $id not found');
    }
  }

  Future<List<Orders>> readAll() async{
    final db = await instance.database;
    final orderBy = '${OrdersFields.name} ASC';
    final result = await db.query(tableOrders, orderBy: orderBy);
    return result.map((json) => Orders.fromJson(json)).toList();
  }
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}