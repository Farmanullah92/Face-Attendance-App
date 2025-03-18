// import 'dart:async';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();

//   static Database? _database;
//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('face_attendance.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//     );
//   }

//   Future _createDB(Database db, int version) async {
//     // Create table for employees.
//     await db.execute('''
//       CREATE TABLE employees (
//         employeeId TEXT PRIMARY KEY,
//         name TEXT NOT NULL,
//         company TEXT NOT NULL,
//         faceTemplate TEXT
//       )
//     ''');
//     // Create table for attendance records.
//     await db.execute('''
//       CREATE TABLE attendance (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         employeeId TEXT NOT NULL,
//         timestamp INTEGER NOT NULL
//       )
//     ''');
//   }

//   Future close() async {
//     final db = await instance.database;
//     db.close();
//   }
// }
// import 'dart:async';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('face_attendance.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   Future _createDB(Database db, int version) async {
//     // Employee table: id, name, employeeId, company, faceImagePath
//     const String tableEmployees = '''
//   CREATE TABLE employees (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     name TEXT NOT NULL,
//     employeeId TEXT NOT NULL,
//     company TEXT NOT NULL,
//     faceImagePath TEXT
//   )
// ''';

//     // Attendance table: id, employeeId, timestamp
//     await db.execute('''
//       CREATE TABLE attendance (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         employeeId INTEGER NOT NULL,
//         timestamp TEXT NOT NULL
//       )
//     ''');
//   }

//   Future close() async {
//     final db = await instance.database;
//     db.close();
//   }
// }
// import 'dart:async';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('face_attendance.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(
//       path,
//       version: 2, // Updated version to ensure table recreation
//       onCreate: _createDB,
//       onUpgrade: _onUpgrade,
//     );
//   }

//   Future _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE employees (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT NOT NULL,
//         employeeId TEXT NOT NULL,
//         company TEXT NOT NULL,
//         faceImagePath TEXT
//       )
//     ''');

//     await db.execute('''
//       CREATE TABLE attendance (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         employeeId INTEGER NOT NULL,
//         timestamp TEXT NOT NULL
//       )
//     ''');
//   }

//   Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     if (oldVersion < 2) {
//       // Drop the existing table and recreate it (only for debugging, remove in production)
//       await db.execute("DROP TABLE IF EXISTS employees");
//       await db.execute("DROP TABLE IF EXISTS attendance");
//       await _createDB(db, newVersion);
//     }
//   }

//   Future close() async {
//     final db = await instance.database;
//     db.close();
//   }
// }
// import 'dart:async';

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('face_attendance.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     // Increase version to 2 so onUpgrade is triggered if needed.
//     return await openDatabase(
//       path,
//       version: 2,
//       onCreate: _createDB,
//       onUpgrade: _onUpgrade, // **CHANGED: Added onUpgrade callback**
//     );
//   }

//   Future _createDB(Database db, int version) async {
//     // Create employees table with faceSignature column.
//     await db.execute('''
//       CREATE TABLE employees (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT NOT NULL,
//         employeeId TEXT NOT NULL,
//         company TEXT NOT NULL,
//         faceSignature TEXT
//       )
//     ''');
//     await db.execute('''
//       CREATE TABLE attendance (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         employeeId INTEGER NOT NULL,
//         timestamp TEXT NOT NULL
//       )
//     ''');
//   }

//   // **CHANGED: onUpgrade callback to add the faceSignature column if missing**
//   Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     if (oldVersion < 2) {
//       // If the old version did not have the faceSignature column,
//       // add it now.
//       await db.execute('ALTER TABLE employees ADD COLUMN faceSignature TEXT');
//     }
//   }

//   Future close() async {
//     final db = await instance.database;
//     db.close();
//   }
// }
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('face_attendance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, // Updated version to ensure table recreation
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        employeeId TEXT NOT NULL,
        company TEXT NOT NULL,
        faceEmbedding TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE attendance (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        employeeId INTEGER NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // For debugging purposes, drop and recreate the tables.
      // In production, implement a proper migration strategy.
      await db.execute("DROP TABLE IF EXISTS employees");
      await db.execute("DROP TABLE IF EXISTS attendance");
      await _createDB(db, newVersion);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
