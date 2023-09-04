import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference students = FirebaseFirestore.instance.collection('students');

Future<void> addStudent(String fullName, String grade, int age) {
  return students
      .add({
        'full_name': fullName, 
        'grade': grade, 
        'age': age
      })
      .then((value) => print("Student data Added"))
      .catchError((error) => print("Student couldn't be added."));
}

Future<void> setStudent(String documentId, String fullName, String grade, int age) {
  return students.doc(documentId).set({
    'full_name': fullName, 
    'grade': grade, 
    'age': age
  })
  .then((value) => print("Student data Set"))
  .catchError((error) => print("Failed to set data for student."));
}

Future<void> updateStudent(String documentId, String newGrade) {
  return students.doc(documentId)
    .update({'grade': newGrade})
    .then((value) => print("Student data Updated"))
    .catchError((error) => print("Failed to update data for student."));
}
