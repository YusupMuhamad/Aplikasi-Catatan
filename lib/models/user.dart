import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String id;
  late String email;

  UserModel({required this.id, required this.email});

  UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc["id"];
    email = doc["email"];
  }
}
