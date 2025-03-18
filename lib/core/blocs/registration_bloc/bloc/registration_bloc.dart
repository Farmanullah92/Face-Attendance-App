import 'package:bloc/bloc.dart';

import '../../../repositories/employee_repository.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final EmployeeRepository repository;

  RegistrationBloc({required this.repository}) : super(RegistrationInitial()) {
    on<RegisterEmployeeEvent>((event, emit) async {
      emit(RegistrationLoading());
      try {
        // This call will throw an exception if the employee ID exists.
        await repository.addEmployee(event.employee);
        emit(RegistrationSuccess());
      } catch (e) {
        emit(RegistrationFailure(e.toString()));
      }
    });
  }
}
