import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "main.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE account (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT, 
        type INTEGER,
        icon TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE trade_cate (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT, 
        icon TEXT,
        type INTEGER,
        operate INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE trade (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        account_id INTEGER,
        trade_cate_id INTEGER,
        money TEXT,
        spend_date TEXT,
        remark TEXT
      )
    ''');

    // 初始化账户
    await db.insert("account", {
      "name": "支付宝",
      "type": 1,
      "icon": "yundong",
    });
    await db.insert("account", {
      "name": "微信",
      "type": 1,
      "icon": "canyin",
    });
    await db.insert("account", {
      "name": "京东白条",
      "type": 2,
      "icon": "feiji",
    });
    // 初始化分类
    await db.insert("trade_cate", {
      "name": "工资",
      "type": 2,
      "icon": "gongzi",
      "operate": 1,
    });
    await db.insert("trade_cate", {
      "name": "飞机",
      "type": 2,
      "icon": "feiji",
      "operate": 2,
    });
    // 新建一条测试数据
    await db.insert("trade", {
      "account_id": 1,
      "trade_cate_id": 1,
      "money": "20.99",
      "spend_date": "2023-03-21",
      "remark": "午饭",
    });
  }
}
