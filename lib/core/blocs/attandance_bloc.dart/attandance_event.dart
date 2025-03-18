abstract class AttendanceEvent {}

class MarkAttendanceEvent extends AttendanceEvent {
  final String capturedImagePath;
  MarkAttendanceEvent(this.capturedImagePath);
}
