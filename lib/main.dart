import 'package:assignmentpro/firebase_options.dart';
import 'package:assignmentpro/method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student '),
        ),
        body: StudentForm(),
      ),
    );
  }
}

class StudentForm extends StatefulWidget {
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Future<void> addStudent(String fullName, String grade, int age) async {
    CollectionReference students = FirebaseFirestore.instance.collection('students');

    try {
      await students.add({
        'full_name': fullName,
        'grade': grade,
        'age': age,
      });
      print('Student data Added');
    } catch (error) {
      print('Failed to add student data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          TextField(
            controller: fullNameController,
            decoration: InputDecoration(labelText: 'Full Name'),
          ),
          TextField(
            controller: gradeController,
            decoration: InputDecoration(labelText: 'Grade'),
          ),
          TextField(
            controller: ageController,
            decoration: InputDecoration(labelText: 'Age'),
          ),
          ElevatedButton(
            onPressed: () {
              String fullName = fullNameController.text;
              String grade = gradeController.text;
              int age = int.tryParse(ageController.text) ?? 0;

              addStudent(fullName, grade, age);
            },
            child: Text('Add Student'),
          ),
        ],
      ),
    );
  }
}