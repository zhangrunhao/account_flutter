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
        icon TEXT,
        money TEXT
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
        remark TEXT,
        sign TEXT
      )
    ''');
    await db.execute('''
        CREATE VIEW v_trade AS
          SELECT
            t.id AS id,
            a.id AS account_id,
            a.name AS account_name, 
            c.id AS trade_cate_id,
            c.name AS trade_cate_name,
            c.operate AS operate,
            t.money AS money,
            t.remark AS remark,
            t.spend_date AS spend_date,
            t.sign AS sign
          FROM trade t,  account a, trade_cate c
          WHERE t.account_id = a.id
            AND t.trade_cate_id = c.id;
    ''');

    // 初始化账户
    await db.insert("account", {
      "name": "支付宝",
      "type": 1,
      "icon": "zhifubao",
      "money": 10,
    });
    await db.insert("account", {
      "name": "微信",
      "type": 1,
      "icon": "weixin",
      "money": 0,
    });
    await db.insert("account", {
      "name": "京东白条",
      "type": 2,
      "icon": "jd",
      "money": 0,
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
      "money": "20",
      "spend_date": "2023-03-21",
      "remark": "午饭",
      "sign": "add"
    });
  }
}
