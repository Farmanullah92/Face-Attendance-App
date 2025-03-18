import 'package:face_attendance_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/blocs/attandance_bloc.dart/attandance_bloc.dart';
import '../../core/blocs/attandance_bloc.dart/attandance_event.dart';
import '../../core/blocs/attandance_bloc.dart/attandance_state.dart';

class FaceAttendanceScreen extends StatefulWidget {
  const FaceAttendanceScreen({super.key});

  @override
  _FaceAttendanceScreenState createState() => _FaceAttendanceScreenState();
}

class _FaceAttendanceScreenState extends State<FaceAttendanceScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _captureAttendance() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      context.read<AttendanceBloc>().add(MarkAttendanceEvent(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Face Attendance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AttendanceBloc, AttendanceState>(
          listener: (context, state) {
            if (state is AttendanceSuccess) {
              context.showCustomSnackBar(state.message);
            } else if (state is AttendanceFailure) {
              context.showCustomSnackBar(state.error);
            }
          },
          builder: (context, state) {
            if (state is AttendanceLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: ElevatedButton(
                onPressed: _captureAttendance,
                child: const Text('Mark Attendance'),
              ),
            );
          },
        ),
      ),
    );
  }
}
