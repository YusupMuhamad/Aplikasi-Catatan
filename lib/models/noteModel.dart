import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  late String id;
  late String title;
  late String body;
  late Timestamp creationDate;

  NoteModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.creationDate});

  NoteModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot["id"];
    title = documentSnapshot['title'];
    body = documentSnapshot["body"];
    creationDate = documentSnapshot["creationDate"];
  }

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json["body"];
    creationDate = json["creationDate"];
  }
}
