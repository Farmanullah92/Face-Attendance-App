abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceSuccess extends AttendanceState {
  final String message;
  AttendanceSuccess(this.message);
}

class AttendanceFailure extends AttendanceState {
  final String error;
  AttendanceFailure(this.error);
}
