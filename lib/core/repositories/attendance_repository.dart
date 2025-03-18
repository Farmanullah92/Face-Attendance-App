import '../../core/db/database_helper.dart';
import '../models/attendance.dart';

class AttendanceRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<void> markAttendance(Attendance attendance) async {
    final db = await databaseHelper.database;
    await db.insert('attendance', attendance.toMap());
  }

  Future<List<Attendance>> getAttendanceRecords() async {
    final db = await databaseHelper.database;
    final maps = await db.query('attendance', orderBy: 'timestamp DESC');
    return maps.map((map) => Attendance.fromMap(map)).toList();
  }
}
