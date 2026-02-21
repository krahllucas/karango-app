import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static const _dbName = 'karango4.db';
  static const _dbVersion = 17;

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
        is_full_tank INTEGER NOT NULL,
        payment_method_id INTEGER NOT NULL
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

    // Tipos de Serviços
    await db.execute('''
      CREATE TABLE service_type (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await ensureServiceTypesData(db);

    // Tipos de Despesas
    await db.execute('''
      CREATE TABLE expense_type (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await ensureExpenseTypesData(db);

    //Formas de Pagamento
    await db.execute('''
      CREATE TABLE payment_method (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
     ''');

     await ensurePaymentMethodsData(db);
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

  static Future<void> ensureServiceTypesData(sql.Database db) async {
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM service_type');
    final count = result.first['count'] as int;

    if (count == 0) {
      await db.execute("INSERT INTO service_type (name) VALUES ('Ar Condicionado');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Bateria');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Bomba de Combustível');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Direção Hidráulica');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Correias');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Filtro de Ar');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Filtro de Combustível');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Filtro de Óleo');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Fluido de Freio');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Fluido de Transmissão');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Fluido de Direção Hidráulica');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Fluido de Suspensão');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Fluido de Arrefecimento');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Limpadores de Para-brisa');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Luzes');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Mão de Obra');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Pastilha de Freio');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Pneus');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Alinhamento e Balanceamento de Rodas');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Rodizio de Pneus');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Radiador');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Revisão');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Som');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Suspenção');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Troca de Freio');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Troca de Óleo');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Manutenção de Ar Condicionado');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Velas de Ignição');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Vidros e Espelhos');");
      await db.execute("INSERT INTO service_type (name) VALUES ('Outros');");
    }
  }

  static Future<void> ensureExpenseTypesData(sql.Database db) async {
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM expense_type');
    final count = result.first['count'] as int;

    if (count == 0) {
      await db.execute("INSERT INTO expense_type (name) VALUES ('Aquisição');");
      await db.execute("INSERT INTO expense_type (name) VALUES ('Estacionamento');");
      await db.execute("INSERT INTO expense_type (name) VALUES ('Financiamento');");
      await db.execute("INSERT INTO expense_type (name) VALUES ('IPVA');");
      await db.execute("INSERT INTO expense_type (name) VALUES ('Licenciamento Anual');");
      await db.execute("INSERT INTO expense_type (name) VALUES ('Seguro DPVAT');");
      await db.execute("INSERT INTO expense_type (name) VALUES ('Lava-rápido');");
      await db.execute("INSERT INTO expense_type (name) VALUES ('Multa');");
      await db.execute("INSERT INTO expense_type (name) VALUES ('Pedágio');");
      await db.execute("INSERT INTO expense_type (name) VALUES ('Seguro Particular');");
      await db.execute("INSERT INTO expense_type (name) VALUES ('Transporte especial (balsa, ferry, guincho)');");
    }
  }

  static Future<void> ensurePaymentMethodsData(sql.Database db) async {
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM payment_method');
    final count = result.first['count'] as int;

    if (count == 0) {
      await db.execute("INSERT INTO payment_method (name) VALUES ('Dinheiro');");
      await db.execute("INSERT INTO payment_method (name) VALUES ('Cartão de Crédito');");
      await db.execute("INSERT INTO payment_method (name) VALUES ('Cartão de Débito');");
      await db.execute("INSERT INTO payment_method (name) VALUES ('Pix');");
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
    }else if (oldVersion < 10) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS service_type (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        );
      ''');

      await ensureServiceTypesData(db);
    }else if (oldVersion < 11) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS expense_type (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        );
      ''');

      await ensureExpenseTypesData(db);
    }else if (oldVersion < 15) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS payment_method (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        );
      ''');

      await ensurePaymentMethodsData(db);
    } else if (oldVersion < 17) {
      await db.execute('''
        ALTER TABLE refueling ADD COLUMN payment_method_id INTEGER NOT NULL DEFAULT 1;
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
