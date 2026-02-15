import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static const _dbName = 'karango4.db';
  static const _dbVersion = 9;

  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    print('Caminho do banco de dados: $dbPath');

    print('Versão do banco de dados: $_dbVersion');

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
        tank_volume REAL NOT NULL,
        fuel_types TEXT NOT NULL
      )
    ''');

    // versão 2 já deve criar também
    await db.execute('''
      CREATE TABLE refueling (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        car_id INTEGER NOT NULL,
        date_time TEXT NOT NULL,
        odometer INTEGER NOT NULL,
        fuel_id INTEGER NOT NULL,
        price_per_liter REAL NOT NULL,
        total_cost REAL NOT NULL,
        liters REAL NOT NULL,
        location TEXT,
        is_full_tank INTEGER NOT NULL
      )
    ''');

    // versão 3 já deve criar também
    await db.execute('''
      CREATE TABLE fuel (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type INTEGER NOT NULL
      );
    ''');

    await ensureFuelData(db);
  }

  static Future<void> ensureFuelData(sql.Database db) async {
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM fuel');
    final count = result.first['count'] as int;

    if (count == 0) {
      await db.execute("INSERT INTO fuel (name, type) VALUES ('Gasolina Comum', 1);");
      await db.execute("INSERT INTO fuel (name, type) VALUES ('Gasolina Aditivada', 1);");
      await db.execute("INSERT INTO fuel (name, type) VALUES ('Gasolina Premium', 1);");
      await db.execute("INSERT INTO fuel (name, type) VALUES ('Etanol', 2);");
      await db.execute("INSERT INTO fuel (name, type) VALUES ('Diesel', 3);");
    }
  }

  static Future<void> _onUpgrade(
    sql.Database db,
    int oldVersion,
    int newVersion,
  ) async {
    print('Atualizando banco de dados da versão $oldVersion para $newVersion');
    
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE refueling (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          car_id INTEGER NOT NULL,
          date_time TEXT NOT NULL,
          odometer INTEGER NOT NULL,
          fuel_id INTEGER NOT NULL,
          price_per_liter REAL NOT NULL,
          total_cost REAL NOT NULL,
          liters REAL NOT NULL,
          location TEXT,
          is_full_tank INTEGER NOT NULL
        )
      ''');
    } else if (oldVersion < 4) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS fuel (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          type INTEGER NOT NULL
        );
      ''');

      await ensureFuelData(db);
    } else if (oldVersion < 6) {
      await db.execute('''
        DELETE FROM fuel;
      ''');
      await ensureFuelData(db);
    }else if (oldVersion < 9) {
      await db.execute('''
        ALTER TABLE car ADD COLUMN fuel_types TEXT NOT NULL DEFAULT '1';
      ''');
    } else if (oldVersion < 8) {
      await db.execute('''
        ALTER TABLE refueling ADD COLUMN fuel_id INTEGER NOT NULL DEFAULT 1;
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
