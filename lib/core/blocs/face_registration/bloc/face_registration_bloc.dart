import 'package:bloc/bloc.dart';
import '../../../models/employee.dart';
import '../../../repositories/employee_repository.dart';
import 'face_registration_event.dart';
import 'face_registration_state.dart';

class FaceRegistrationBloc
    extends Bloc<RegisterFaceEvent, FaceRegistrationState> {
  final EmployeeRepository repository;

  FaceRegistrationBloc({required this.repository})
      : super(FaceRegistrationInitial()) {
    on<RegisterFaceEvent>((event, emit) async {
      emit(FaceRegistrationLoading());
      try {
        // Compute the face embedding from the captured image.
        final embedding =
            await repository.computeFaceEmbedding(event.capturedImagePath);
        // Check if this embedding is already registered to another employee.
        bool exists = await repository.isFaceAlreadyRegistered(
          embedding,
          excludeEmployeeId: event.employee.id,
        );
        if (exists) {
          emit(FaceRegistrationFailure(
              "This face is already registered to another employee."));
          return;
        }
        // Update the employee record with the computed face embedding.
        Employee updated = Employee(
          id: event.employee.id,
          name: event.employee.name,
          employeeId: event.employee.employeeId,
          company: event.employee.company,
          faceEmbedding: embedding,
        );
        await repository.updateEmployee(updated);
        emit(FaceRegistrationSuccess());
      } catch (e) {
        emit(FaceRegistrationFailure(e.toString()));
      }
    });
  }
}
