import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/blocs/attandance_bloc.dart/attandance_bloc.dart';
import 'core/blocs/face_registration/bloc/face_registration_bloc.dart';
import 'core/blocs/registration_bloc/bloc/registration_bloc.dart';
import 'core/db/database_helper.dart';
import 'core/repositories/employee_repository.dart';
import 'screens/employee_registration_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = EmployeeRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationBloc>(
          create: (_) => RegistrationBloc(repository: repository),
        ),
        BlocProvider<FaceRegistrationBloc>(
          create: (_) => FaceRegistrationBloc(repository: repository),
        ),
        BlocProvider<AttendanceBloc>(
          create: (_) => AttendanceBloc(repository: repository),
        ),
      ],
      child: MaterialApp(
        title: 'Face Attendance App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const EmployeeRegistrationScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
