// class Attendance {
//   final int? id;
//   final String employeeId;
//   final DateTime timestamp;

//   Attendance({
//     this.id,
//     required this.employeeId,
//     required this.timestamp,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'employeeId': employeeId,
//       'timestamp': timestamp.millisecondsSinceEpoch,
//     };
//   }

//   factory Attendance.fromMap(Map<String, dynamic> map) {
//     return Attendance(
//       id: map['id'],
//       employeeId: map['employeeId'],
//       timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
//     );
//   }
// }
class Attendance {
  final int? id;
  final int employeeId;
  final String timestamp;

  Attendance({
    this.id,
    required this.employeeId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeId': employeeId,
      'timestamp': timestamp,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      employeeId: map['employeeId'],
      timestamp: map['timestamp'],
    );
  }
}
