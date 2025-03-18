// // import '../../core/db/database_helper.dart';
// // import '../models/employee.dart';

// // class EmployeeRepository {
// //   final DatabaseHelper databaseHelper = DatabaseHelper.instance;

// //   Future<void> addEmployee(Employee employee) async {
// //     final db = await databaseHelper.database;
// //     // Try inserting; if an employee with the same ID exists, an exception will be thrown.
// //     await db.insert('employees', employee.toMap());
// //   }

// //   Future<List<Employee>> getEmployees() async {
// //     final db = await databaseHelper.database;
// //     final maps = await db.query('employees');
// //     return maps.map((map) => Employee.fromMap(map)).toList();
// //   }

// //   Future<void> updateEmployee(Employee employee) async {
// //     final db = await databaseHelper.database;
// //     final count = await db.update(
// //       'employees',
// //       employee.toMap(),
// //       where: 'employeeId = ?',
// //       whereArgs: [employee.employeeId],
// //     );
// //     if (count == 0) throw Exception("Employee not found");
// //   }
// // }
// import '../../core/db/database_helper.dart';
// import '../models/attendance.dart';
// import '../models/employee.dart';

// class EmployeeRepository {
//   final DatabaseHelper dbHelper = DatabaseHelper.instance;

//   Future<int> addEmployee(Employee employee) async {
//     final db = await dbHelper.database;
//     return await db.insert('employees', employee.toMap());
//   }

//   Future<List<Employee>> getEmployees() async {
//     final db = await dbHelper.database;
//     final maps = await db.query('employees');
//     return maps.map((map) => Employee.fromMap(map)).toList();
//   }

//   Future<int> updateEmployee(Employee employee) async {
//     final db = await dbHelper.database;
//     return await db.update('employees', employee.toMap(),
//         where: 'id = ?', whereArgs: [employee.id]);
//   }

//   Future<int> addAttendance(Attendance attendance) async {
//     final db = await dbHelper.database;
//     return await db.insert('attendance', attendance.toMap());
//   }

//   /// Dummy face matching function.
//   /// In a real app, you would use a face recognition library.
//   bool dummyFaceMatch(String? registeredFace, String capturedFace) {
//     // For simulation, if the strings are equal, return true.
//     // (In practice, the captured image path will be different, so this is just a stub.)
//     return registeredFace != null && registeredFace == capturedFace;
//   }

//   /// Check if a face image (captured) is already registered to any employee.
//   Future<bool> isFaceAlreadyRegistered(String capturedFace) async {
//     final employees = await getEmployees();
//     for (var emp in employees) {
//       if (emp.faceImagePath != null &&
//           dummyFaceMatch(emp.faceImagePath, capturedFace)) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
// import '../../core/db/database_helper.dart';
// import '../models/attendance.dart';
// import '../models/employee.dart';

// class EmployeeRepository {
//   final DatabaseHelper dbHelper = DatabaseHelper.instance;

//   // NEW: Check if an employee ID already exists
//   Future<bool> isEmployeeIdExists(String employeeId) async {
//     final db = await dbHelper.database;
//     final maps = await db
//         .query('employees', where: 'employeeId = ?', whereArgs: [employeeId]);
//     return maps.isNotEmpty;
//   }

//   Future<int> addEmployee(Employee employee) async {
//     // Before insertion, check for duplicate employee ID.
//     if (await isEmployeeIdExists(employee.employeeId)) {
//       throw Exception("Employee ID already exists");
//     }
//     final db = await dbHelper.database;
//     // Do not include the id field; SQLite will auto-generate it.
//     return await db.insert('employees', {
//       'name': employee.name,
//       'employeeId': employee.employeeId,
//       'company': employee.company,
//       'faceImagePath': employee.faceImagePath,
//     });
//   }

//   Future<List<Employee>> getEmployees() async {
//     final db = await dbHelper.database;
//     final maps = await db.query('employees');
//     return maps.map((map) => Employee.fromMap(map)).toList();
//   }

//   Future<int> updateEmployee(Employee employee) async {
//     final db = await dbHelper.database;
//     return await db.update('employees', employee.toMap(),
//         where: 'id = ?', whereArgs: [employee.id]);
//   }

//   Future<int> addAttendance(Attendance attendance) async {
//     final db = await dbHelper.database;
//     return await db.insert('attendance', attendance.toMap());
//   }

//   /// Updated dummy face matching: trims and lowercases both strings.
//   bool dummyFaceMatch(String? registeredFace, String capturedFace) {
//     if (registeredFace == null) return false;
//     return registeredFace.trim().toLowerCase() ==
//         capturedFace.trim().toLowerCase();
//   }

//   /// Check if a face image (captured) is already registered.
//   Future<bool> isFaceAlreadyRegistered(String capturedFace) async {
//     final employees = await getEmployees();
//     for (var emp in employees) {
//       if (emp.faceImagePath != null &&
//           dummyFaceMatch(emp.faceImagePath, capturedFace)) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
// import 'dart:io';

// import 'package:crypto/crypto.dart';

// import '../../core/db/database_helper.dart';
// import '../models/attendance.dart';
// import '../models/employee.dart';

// class EmployeeRepository {
//   final DatabaseHelper dbHelper = DatabaseHelper.instance;

//   Future<bool> isEmployeeIdExists(String employeeId) async {
//     final db = await dbHelper.database;
//     final maps = await db
//         .query('employees', where: 'employeeId = ?', whereArgs: [employeeId]);
//     return maps.isNotEmpty;
//   }

//   Future<int> addEmployee(Employee employee) async {
//     if (await isEmployeeIdExists(employee.employeeId)) {
//       throw Exception("Employee ID already exists");
//     }
//     final db = await dbHelper.database;
//     return await db.insert('employees', {
//       'name': employee.name,
//       'employeeId': employee.employeeId,
//       'company': employee.company,
//       'faceSignature': employee.faceSignature, // CHANGED
//     });
//   }

//   Future<List<Employee>> getEmployees() async {
//     final db = await dbHelper.database;
//     final maps = await db.query('employees');
//     return maps.map((map) => Employee.fromMap(map)).toList();
//   }

//   Future<int> updateEmployee(Employee employee) async {
//     final db = await dbHelper.database;
//     return await db.update('employees', employee.toMap(),
//         where: 'id = ?', whereArgs: [employee.id]);
//   }

//   Future<int> addAttendance(Attendance attendance) async {
//     final db = await dbHelper.database;
//     return await db.insert('attendance', attendance.toMap());
//   }

//   /// Compute an MD5 hash of the image file contents to simulate a face signature.
//   Future<String> computeFaceSignature(String imagePath) async {
//     final bytes = await File(imagePath).readAsBytes();
//     final digest = md5.convert(bytes);
//     return digest.toString();
//   }

//   /// Compare stored faceSignature with captured signature.
//   bool dummyFaceMatch(String? registeredSignature, String capturedSignature) {
//     if (registeredSignature == null) return false;
//     return registeredSignature.trim().toLowerCase() ==
//         capturedSignature.trim().toLowerCase();
//   }

//   /// Check if a captured face signature is already registered.
//   Future<bool> isFaceAlreadyRegistered(String capturedSignature) async {
//     final employees = await getEmployees();
//     for (var emp in employees) {
//       if (emp.faceSignature != null &&
//           dummyFaceMatch(emp.faceSignature, capturedSignature)) {
//         return true;
//       }
//     }
//     return false;
//   }
// }

// import 'dart:convert';
// import 'dart:math';

// import '../../core/db/database_helper.dart';
// import '../../core/models/face_embedding_model.dart';
// import '../models/attendance.dart';
// import '../models/employee.dart';

// class EmployeeRepository {
//   final DatabaseHelper dbHelper = DatabaseHelper.instance;
//   final FaceEmbeddingModel faceModel = FaceEmbeddingModel();

//   Future<bool> isEmployeeIdExists(String employeeId) async {
//     final db = await dbHelper.database;
//     final maps = await db
//         .query('employees', where: 'employeeId = ?', whereArgs: [employeeId]);
//     return maps.isNotEmpty;
//   }

//   Future<int> addEmployee(Employee employee) async {
//     if (await isEmployeeIdExists(employee.employeeId)) {
//       throw Exception("Employee ID already exists");
//     }
//     final db = await dbHelper.database;
//     return await db.insert('employees', {
//       'name': employee.name,
//       'employeeId': employee.employeeId,
//       'company': employee.company,
//       'faceEmbedding': employee.faceEmbedding != null
//           ? jsonEncode(employee.faceEmbedding)
//           : null,
//     });
//   }

//   Future<List<Employee>> getEmployees() async {
//     final db = await dbHelper.database;
//     final maps = await db.query('employees');
//     return maps.map((map) => Employee.fromMap(map)).toList();
//   }

//   Future<int> updateEmployee(Employee employee) async {
//     final db = await dbHelper.database;
//     return await db.update('employees', employee.toMap(),
//         where: 'id = ?', whereArgs: [employee.id]);
//   }

//   Future<int> addAttendance(Attendance attendance) async {
//     final db = await dbHelper.database;
//     return await db.insert('attendance', attendance.toMap());
//   }

//   /// Compute face embedding from image using the TFLite model.
//   Future<List<double>> computeFaceEmbedding(String imagePath) async {
//     return await faceModel.runInference(imagePath);
//   }

//   /// Compute cosine similarity between two embedding vectors.
//   double cosineSimilarity(List<double> a, List<double> b) {
//     double dot = 0, normA = 0, normB = 0;
//     for (int i = 0; i < a.length; i++) {
//       dot += a[i] * b[i];
//       normA += a[i] * a[i];
//       normB += b[i] * b[i];
//     }
//     if (normA == 0 || normB == 0) return 0;
//     return dot / (sqrt(normA) * sqrt(normB));
//   }

//   /// Return true if the similarity is above the threshold.
//   bool embeddingsMatch(
//       List<double>? storedEmbedding, List<double> capturedEmbedding,
//       {double threshold = 0.8}) {
//     if (storedEmbedding == null) return false;
//     double similarity = cosineSimilarity(storedEmbedding, capturedEmbedding);
//     return similarity >= threshold;
//   }

//   /// Check if a captured face embedding is already registered, excluding a given employee id.
//   Future<bool> isFaceAlreadyRegistered(List<double> capturedEmbedding,
//       {int? excludeEmployeeId}) async {
//     final employees = await getEmployees();
//     for (var emp in employees) {
//       if (excludeEmployeeId != null && emp.id == excludeEmployeeId) continue;
//       if (emp.faceEmbedding != null &&
//           embeddingsMatch(emp.faceEmbedding, capturedEmbedding)) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
// import 'dart:convert';
// import 'dart:math';

// import '../../core/db/database_helper.dart';
// import '../../core/models/face_embedding_model.dart';
// import '../models/attendance.dart';
// import '../models/employee.dart';

// class EmployeeRepository {
//   final DatabaseHelper dbHelper = DatabaseHelper.instance;
//   final FaceEmbeddingModel faceModel = FaceEmbeddingModel();

//   Future<bool> isEmployeeIdExists(String employeeId) async {
//     final db = await dbHelper.database;
//     final maps = await db
//         .query('employees', where: 'employeeId = ?', whereArgs: [employeeId]);
//     return maps.isNotEmpty;
//   }

//   Future<int> addEmployee(Employee employee) async {
//     if (await isEmployeeIdExists(employee.employeeId)) {
//       throw Exception("Employee ID already exists");
//     }
//     final db = await dbHelper.database;
//     return await db.insert('employees', {
//       'name': employee.name,
//       'employeeId': employee.employeeId,
//       'company': employee.company,
//       'faceEmbedding': employee.faceEmbedding != null
//           ? jsonEncode(employee.faceEmbedding)
//           : null,
//     });
//   }

//   Future<List<Employee>> getEmployees() async {
//     final db = await dbHelper.database;
//     final maps = await db.query('employees');
//     return maps.map((map) => Employee.fromMap(map)).toList();
//   }

//   Future<int> updateEmployee(Employee employee) async {
//     final db = await dbHelper.database;
//     return await db.update('employees', employee.toMap(),
//         where: 'id = ?', whereArgs: [employee.id]);
//   }

//   Future<int> addAttendance(Attendance attendance) async {
//     final db = await dbHelper.database;
//     return await db.insert('attendance', attendance.toMap());
//   }

//   /// Compute face embedding from image using the TFLite model.
//   Future<List<double>> computeFaceEmbedding(String imagePath) async {
//     return await faceModel.runInference(imagePath);
//   }

//   /// Compute cosine similarity between two embedding vectors.
//   double cosineSimilarity(List<double> a, List<double> b) {
//     double dot = 0, normA = 0, normB = 0;
//     for (int i = 0; i < a.length; i++) {
//       dot += a[i] * b[i];
//       normA += a[i] * a[i];
//       normB += b[i] * b[i];
//     }
//     if (normA == 0 || normB == 0) return 0;
//     return dot / (sqrt(normA) * sqrt(normB));
//   }

//   /// Return true if the similarity is above the threshold.
//   bool embeddingsMatch(
//       List<double>? storedEmbedding, List<double> capturedEmbedding,
//       {double threshold = 0.8}) {
//     if (storedEmbedding == null) return false;
//     double similarity = cosineSimilarity(storedEmbedding, capturedEmbedding);
//     return similarity >= threshold;
//   }

//   /// Check if a captured face embedding is already registered, excluding a given employee id.
//   Future<bool> isFaceAlreadyRegistered(List<double> capturedEmbedding,
//       {int? excludeEmployeeId}) async {
//     final employees = await getEmployees();
//     for (var emp in employees) {
//       if (excludeEmployeeId != null && emp.id == excludeEmployeeId) continue;
//       if (emp.faceEmbedding != null &&
//           embeddingsMatch(emp.faceEmbedding, capturedEmbedding)) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
import 'dart:convert';
import 'dart:math';

import '../../core/db/database_helper.dart';
import '../../core/models/face_embedding_model.dart';
import '../models/attendance.dart';
import '../models/employee.dart';

class EmployeeRepository {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final FaceEmbeddingModel faceModel = FaceEmbeddingModel();

  Future<bool> isEmployeeIdExists(String employeeId) async {
    final db = await dbHelper.database;
    final maps = await db
        .query('employees', where: 'employeeId = ?', whereArgs: [employeeId]);
    return maps.isNotEmpty;
  }

  Future<int> addEmployee(Employee employee) async {
    if (await isEmployeeIdExists(employee.employeeId)) {
      throw Exception("Employee ID already exists");
    }
    final db = await dbHelper.database;
    return await db.insert('employees', {
      'name': employee.name,
      'employeeId': employee.employeeId,
      'company': employee.company,
      'faceEmbedding': employee.faceEmbedding != null
          ? jsonEncode(employee.faceEmbedding)
          : null,
    });
  }

  Future<List<Employee>> getEmployees() async {
    final db = await dbHelper.database;
    final maps = await db.query('employees');
    return maps.map((map) => Employee.fromMap(map)).toList();
  }

  Future<int> updateEmployee(Employee employee) async {
    final db = await dbHelper.database;
    return await db.update('employees', employee.toMap(),
        where: 'id = ?', whereArgs: [employee.id]);
  }

  Future<int> addAttendance(Attendance attendance) async {
    final db = await dbHelper.database;
    return await db.insert('attendance', attendance.toMap());
  }

  /// Compute face embedding from image using TFLite.
  Future<List<double>> computeFaceEmbedding(String imagePath) async {
    return await faceModel.runInference(imagePath);
  }

  /// Compute cosine similarity between two normalized vectors.
  double cosineSimilarity(List<double> a, List<double> b) {
    double dot = 0, normA = 0, normB = 0;
    for (int i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }
    if (normA == 0 || normB == 0) return 0;
    return dot / (sqrt(normA) * sqrt(normB));
  }

  /// Returns true if the cosine similarity is above the threshold.
  bool embeddingsMatch(
      List<double>? storedEmbedding, List<double> capturedEmbedding,
      {double threshold = 0.8}) {
    if (storedEmbedding == null) return false;
    double similarity = cosineSimilarity(storedEmbedding, capturedEmbedding);
    return similarity >= threshold;
  }

  /// Check if a captured face embedding is already registered, optionally excluding a given employee.
  Future<bool> isFaceAlreadyRegistered(List<double> capturedEmbedding,
      {int? excludeEmployeeId}) async {
    final employees = await getEmployees();
    for (var emp in employees) {
      if (excludeEmployeeId != null && emp.id == excludeEmployeeId) continue;
      if (emp.faceEmbedding != null &&
          embeddingsMatch(emp.faceEmbedding, capturedEmbedding)) {
        return true;
      }
    }
    return false;
  }
}
