import 'dart:convert';

class Employee {
  final int? id;
  final String name;
  final String employeeId;
  final String company;
  final List<double>? faceEmbedding;
  bool isFaceRegistered;

  Employee({
    this.id,
    required this.name,
    required this.employeeId,
    required this.company,
    this.faceEmbedding,
    this.isFaceRegistered = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'employeeId': employeeId,
      'company': company,
      'faceEmbedding': faceEmbedding != null ? jsonEncode(faceEmbedding) : null,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      employeeId: map['employeeId'],
      company: map['company'],
      faceEmbedding: map['faceEmbedding'] != null
          ? List<double>.from(jsonDecode(map['faceEmbedding']))
          : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Employee && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
