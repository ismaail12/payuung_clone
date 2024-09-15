import 'package:payuung/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  static Database? _database;

  UserService._internal();

  factory UserService() {
    return _instance;
  }

  // Initialize the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Create the SQLite database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  // Create the User table
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        birthDate TEXT,
        gender TEXT,
        email TEXT,
        phoneNumber TEXT,
        education TEXT,
        maritalStatus TEXT,
        nik TEXT,
        addressKtp TEXT,
        province TEXT,
        companyName TEXT,
        companyAddress TEXT,
        jobTitle TEXT,
        incomeSource TEXT,
        yearlyGrossIncome TEXT,
        bankBranch TEXT,
        bankAccountNumber TEXT,
        bankAccountHolder TEXT
      )
    ''');
  }

  // CRUD Operations

  Future<int> createUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<User?> getUserById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      return null;
    }
  }

  // Read or Fetch all Users
  Future<List<User>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User.fromJson(maps[i]);
    });
  }

  // Update an existing User
  Future<int> updateUser(User user, int id) async {
    final db = await database;
    return await db.update(
      'users',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete a User
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllUsers() async {
    final db = await database;
    return await db.delete('users');
  }
}
