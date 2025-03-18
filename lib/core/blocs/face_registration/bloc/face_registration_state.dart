abstract class FaceRegistrationState {}

class FaceRegistrationInitial extends FaceRegistrationState {}

class FaceRegistrationLoading extends FaceRegistrationState {}

class FaceRegistrationSuccess extends FaceRegistrationState {}

class FaceRegistrationFailure extends FaceRegistrationState {
  final String error;
  FaceRegistrationFailure(this.error);
}
