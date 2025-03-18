import '../../../models/employee.dart';

abstract class RegistrationEvent {}

class RegisterEmployeeEvent extends RegistrationEvent {
  final Employee employee;
  RegisterEmployeeEvent(this.employee);
}
