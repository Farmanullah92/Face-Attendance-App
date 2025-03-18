import '../../../models/employee.dart';

abstract class FaceRegistrationEvent {}

class RegisterFaceEvent extends FaceRegistrationEvent {
  final Employee employee;
  final String capturedImagePath;
  RegisterFaceEvent({required this.employee, required this.capturedImagePath});
}
