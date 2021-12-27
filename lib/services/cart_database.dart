
import 'package:bicycleapp/models/bicycle_data.dart';
import 'package:bicycleapp/models/cart_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase{
  static final CartDatabase instance = CartDatabase._init();

  static Database? _database;
  CartDatabase._init();

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
    CREATE TABLE IF NOT EXISTS $tableCart(
      ${CartFields.id} $idType,
      ${CartFields.name} $textType,
      ${CartFields.amount} $textType
      ${CartFields.picture} $textType
    
     
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

  Future<Cart> create(Cart cart) async {
    final db = await instance.database;
    final id = await db.insert(tableCart, cart.toJson());
    return cart.copy(id:id);
  }

  //Read bicycle data according to ID
  Future<Cart> readData(int user_id) async{
    final db = await instance.database;
    final maps = await db.query(
      tableCart,
      columns: CartFields.values,
      where: '${CartFields.id} = ?',
      whereArgs: [user_id],
    );
    if (maps.isNotEmpty){
      return Cart.fromJson(maps.first);
    }else{
      throw Exception('cart item with userID $user_id not found');
    }
  }

  Future<List<Cart>> readAll() async{
    final db = await instance.database;
    final orderBy = '${CartFields.name} ASC';
    final result = await db.query(tableCart, orderBy: orderBy);
    return result.map((json) => Cart.fromJson(json)).toList();
  }
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}