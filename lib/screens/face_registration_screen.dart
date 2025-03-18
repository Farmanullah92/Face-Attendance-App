import 'package:face_attendance_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/blocs/face_registration/bloc/face_registration_bloc.dart';
import '../../core/blocs/face_registration/bloc/face_registration_event.dart';
import '../../core/blocs/face_registration/bloc/face_registration_state.dart';
import '../../core/models/employee.dart';
import '../../core/repositories/employee_repository.dart';
import 'face_attendance.dart';

class FaceRegistrationScreen extends StatefulWidget {
  const FaceRegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FaceRegistrationScreenState createState() => _FaceRegistrationScreenState();
}

class _FaceRegistrationScreenState extends State<FaceRegistrationScreen> {
  Employee? selectedEmployee;
  final EmployeeRepository repository = EmployeeRepository();
  final ImagePicker _picker = ImagePicker();

  Future<void> _captureFace() async {
    // Open camera to capture image.
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      // ignore: use_build_context_synchronously
      context.showCustomSnackBar("No image captured. Please try again.");
      return;
    }
    if (selectedEmployee == null) {
      // ignore: use_build_context_synchronously
      context.showCustomSnackBar("Please select an employee.");
      return;
    }
    // Dispatch event to register face.
    // ignore: use_build_context_synchronously
    context.read<FaceRegistrationBloc>().add(RegisterFaceEvent(
          employee: selectedEmployee!,
          capturedImagePath: image.path,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Registration'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Employee>>(
        future: repository.getEmployees(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final employees = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: ListTile(
                        title: Text(employee.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Employee ID: ${employee.employeeId}"),
                            Text("Company: ${employee.company}"),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            selectedEmployee = employee;
                          });
                        },
                        tileColor: selectedEmployee == employee
                            ? Colors.blue.withOpacity(0.2)
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _captureFace,
                child: const Text("Register Face"),
              ),
              BlocConsumer<FaceRegistrationBloc, FaceRegistrationState>(
                listener: (context, state) {
                  if (state is FaceRegistrationSuccess) {
                    context.showCustomSnackBar("Face Registered Successfully");
                  } else if (state is FaceRegistrationFailure) {
                    context.showCustomSnackBar(state.error);
                  }
                },
                builder: (context, state) {
                  if (state is FaceRegistrationLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FaceAttendanceScreen(),
                    ),
                  );
                },
                child: const Text("Go to Face Attendance"),
              ),
            ],
          );
        },
      ),
    );
  }
}


// import 'package:face_attendance_app/utils/extension.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../core/blocs/face_registration/bloc/face_registration_bloc.dart';
// import '../../core/blocs/face_registration/bloc/face_registration_event.dart';
// import '../../core/blocs/face_registration/bloc/face_registration_state.dart';
// import '../../core/models/employee.dart';
// import '../../core/repositories/employee_repository.dart';
// import 'face_attendance.dart';

// class FaceRegistrationScreen extends StatefulWidget {
//   const FaceRegistrationScreen({super.key});

//   @override
//   _FaceRegistrationScreenState createState() => _FaceRegistrationScreenState();
// }

// class _FaceRegistrationScreenState extends State<FaceRegistrationScreen> {
//   Employee? selectedEmployee;
//   final EmployeeRepository repository = EmployeeRepository();
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _captureFace() async {
//     // Open camera to capture image.
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     if (image == null) {
//       context.showCustomSnackBar("No image captured. Please try again.");
//       return;
//     }
//     if (selectedEmployee == null) {
//       context.showCustomSnackBar("Please select an employee.");
//       return;
//     }
//     // Dispatch event to register face.
//     context.read<FaceRegistrationBloc>().add(RegisterFaceEvent(
//           employee: selectedEmployee!,
//           capturedImagePath: image.path,
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Face Registration')),
//       body: FutureBuilder<List<Employee>>(
//         future: repository.getEmployees(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final employees = snapshot.data!;

//           // **CHANGED: Use a distinct list to avoid duplicates.**
//           final distinctEmployees = employees.toSet().toList();

//           // **CHANGED: If selectedEmployee is not in the distinct list, reset it.**
//           if (selectedEmployee != null &&
//               !distinctEmployees.contains(selectedEmployee)) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               setState(() {
//                 selectedEmployee = null;
//               });
//             });
//           }

//           return Column(
//             children: [
//               DropdownButton<Employee>(
//                 hint: const Text("Select Employee"),
//                 value: selectedEmployee,
//                 items: distinctEmployees.map((Employee emp) {
//                   return DropdownMenuItem<Employee>(
//                     value: emp,
//                     child: Text(emp.name),
//                   );
//                 }).toList(),
//                 onChanged: (Employee? emp) {
//                   setState(() {
//                     selectedEmployee = emp;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _captureFace,
//                 child: const Text("Register Face"),
//               ),
//               BlocConsumer<FaceRegistrationBloc, FaceRegistrationState>(
//                 listener: (context, state) {
//                   if (state is FaceRegistrationSuccess) {
//                     context.showCustomSnackBar("Face Registered Successfully");
//                   } else if (state is FaceRegistrationFailure) {
//                     context.showCustomSnackBar(state.error);
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is FaceRegistrationLoading) {
//                     return const CircularProgressIndicator();
//                   }
//                   return Container();
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => const FaceAttendanceScreen()),
//                   );
//                 },
//                 child: const Text("Go to Face Attendance"),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
