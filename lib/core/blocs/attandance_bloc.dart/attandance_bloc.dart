import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import '../../models/attendance.dart';
import '../../repositories/employee_repository.dart';
import 'attandance_event.dart';
import 'attandance_state.dart';

class AttendanceBloc extends Bloc<MarkAttendanceEvent, AttendanceState> {
  final EmployeeRepository repository;

  AttendanceBloc({required this.repository}) : super(AttendanceInitial()) {
    on<MarkAttendanceEvent>((event, emit) async {
      emit(AttendanceLoading());
      try {
        // Compute the face embedding for the captured image.
        final capturedEmbedding =
            await repository.computeFaceEmbedding(event.capturedImagePath);
        final employees = await repository.getEmployees();
        for (var emp in employees) {
          if (repository.embeddingsMatch(
              emp.faceEmbedding, capturedEmbedding)) {
            String timestamp =
                DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
            await repository.addAttendance(
                Attendance(employeeId: emp.id!, timestamp: timestamp));
            emit(AttendanceSuccess("Attendance marked for ${emp.name}"));
            return;
          }
        }
        emit(AttendanceFailure("Face not recognized, please try again."));
      } catch (e) {
        emit(AttendanceFailure(e.toString()));
      }
    });
  }
}
