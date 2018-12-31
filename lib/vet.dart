import 'package:cloud_firestore/cloud_firestore.dart';

class Veterinarian {
  final String state;
  final String city;
  final String practiceName;
  final String veterinarian;
  final String phoneNumber;

  final DocumentReference documentReference;

  Veterinarian.fromMap(Map<String, dynamic> map, {this.documentReference})
      : assert(map['Veterinarians'] != null),
        state = map['State'],
        city = map['City'],
        practiceName = map['Practice Name'],
        veterinarian = map['Veterinarians'],
        phoneNumber = map['Phone'];

  Veterinarian.fromSnapshot(DocumentSnapshot documentSnapshot)
      : this.fromMap(documentSnapshot.data,
      documentReference: documentSnapshot.reference);

  @override
  String toString() => "VetDirectory<$practiceName>";
}