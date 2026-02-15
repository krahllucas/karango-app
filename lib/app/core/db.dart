import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static const _dbName = 'karango2.db';
  static const _dbVersion = 2;

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, _dbName),
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(sql.Database db, int version) async {
    // versão 1
    await db.execute('''
      CREATE TABLE car (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        plate TEXT,
        brand TEXT NOT NULL,
        model TEXT NOT NULL,
        year INTEGER NOT NULL,
        tank_volume REAL NOT NULL
      )
    ''');

    // versão 2 já deve criar também
    await db.execute('''
      CREATE TABLE refueling (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        car_id INTEGER NOT NULL,
        date_time TEXT NOT NULL,
        odometer INTEGER NOT NULL,
        fuel_type TEXT NOT NULL,
        price_per_liter REAL NOT NULL,
        total_cost REAL NOT NULL,
        liters REAL NOT NULL,
        location TEXT,
        is_full_tank INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> _onUpgrade(
      sql.Database db, int oldVersion, int newVersion) async {

    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE refueling (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          car_id INTEGER NOT NULL,
          date_time TEXT NOT NULL,
          odometer INTEGER NOT NULL,
          fuel_type TEXT NOT NULL,
          price_per_liter REAL NOT NULL,
          total_cost REAL NOT NULL,
          liters REAL NOT NULL,
          location TEXT,
          is_full_tank INTEGER NOT NULL
        )
      ''');
    }
  }

  static Future<void> insert(String table, Map<String, Object?> data) async {
    final db = await database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database();
    return db.query(table);
  }
}
