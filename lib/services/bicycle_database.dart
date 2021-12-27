
import 'package:bicycleapp/models/bicycle_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BicyclesDatabase{
  static final BicyclesDatabase instance = BicyclesDatabase._init();

  static Database? _database;
  BicyclesDatabase._init();

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
    CREATE TABLE IF NOT EXISTS $tableBicycles(
      ${BicyclesFields.id} $idType,
      ${BicyclesFields.name} $textType,
      ${BicyclesFields.description} $textType,
      ${BicyclesFields.amount} $textType
      ${BicyclesFields.picture} $textType
      ${BicyclesFields.category} $textType
     
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

  Future<Bicycles> create(Bicycles bicycles) async {
    final db = await instance.database;
    final id = await db.insert(tableBicycles, bicycles.toJson());
    return bicycles.copy(id:id);
  }

  //Read bicycle data according to ID
  Future<Bicycles> readData(int id) async{
    final db = await instance.database;
    final maps = await db.query(
      tableBicycles,
      columns: BicyclesFields.values,
      where: '${BicyclesFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty){
      return Bicycles.fromJson(maps.first);
    }else{
      throw Exception('Bicycle with ID $id not found');
    }
  }

  //Read bicycle data according to category
  Future<List<Bicycles>> readWithCategory(String category) async{
    final db = await instance.database;
    final result = await db.query(
      tableBicycles,
      columns: BicyclesFields.values,
      where: '${BicyclesFields.category} = ?',
      whereArgs: [category],
    );
    return result.map((json) => Bicycles.fromJson(json)).toList();
  }

  // Search
  Future<List<Bicycles>> search(String search_string) async{
    final db = await instance.database;
    final result = await db.rawQuery(
        "SELECT * FROM Bicycles WHERE name LIKE '%${search_string}%'");
    return result.map((json) => Bicycles.fromJson(json)).toList();
  }

  Future<List<Bicycles>> readAll() async{
    print("reading all");
    final db = await instance.database;
    final orderBy = '${BicyclesFields.name} ASC';
    final result = await db.query(tableBicycles, orderBy: orderBy);
    print("length result");
    print(result.length);
    return result.map((json) => Bicycles.fromJson(json)).toList();
  }
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}