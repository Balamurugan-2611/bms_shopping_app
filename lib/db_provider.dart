import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static const String DB_NAME = 'shopping.db';
  static const int DB_VERSION = 1;
  static Database? _database;

  DBProvider._internal();

  static final DBProvider instance = DBProvider._internal();
  
  static const List<String> initScripts = [
    CREATE_TABLE_PRODUCT_Q,
    CREATE_TABLE_CART_ITEMS_Q
  ];

  Future<void> init() async {
    try {
      _database = await openDatabase(
        join(await getDatabasesPath(), DB_NAME),
        onCreate: (db, version) async {
          for (var script in initScripts) {
            await db.execute(script);
          }
        },
        onUpgrade: (db, oldVersion, newVersion) {
          // Handle database schema upgrades
          // e.g., adding new tables or columns
        },
        version: DB_VERSION,
      );
    } catch (e) {
      // Handle errors during database initialization
      print('Error initializing database: $e');
    }
  }

  Database get database {
    final db = _database;
    if (db == null) {
      throw Exception('Database not initialized. Call init() first.');
    }
    return db;
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  static const String TABLE_PRODUCT = 'Product';
  static const String CREATE_TABLE_PRODUCT_Q = '''
      CREATE TABLE $TABLE_PRODUCT(
        product_id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        briefDescription TEXT,
        images TEXT,
        colors INTEGER,
        price REAL,
        category TEXT,
        isFavourite INTEGER,
        remainingSizeUK TEXT,
        remainingSizeUS TEXT,
        productType TEXT
      );
    ''';

  static const String TABLE_CART_ITEMS = 'CartItems';
  static const String CREATE_TABLE_CART_ITEMS_Q = '''
      CREATE TABLE $TABLE_CART_ITEMS (
        cart_items_id INTEGER PRIMARY KEY,
        product_id TEXT NOT NULL UNIQUE,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (product_id) REFERENCES $TABLE_PRODUCT (product_id)
      );
    ''';
}
