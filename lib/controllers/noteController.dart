import 'package:flutter/material.dart';
import 'package:flutter_note/controllers/authController.dart';
import 'package:flutter_note/models/noteModel.dart';
import 'package:flutter_note/services/database.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  RxList<NoteModel> noteList = RxList<NoteModel>();
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> bodyController = TextEditingController().obs;

  List<NoteModel> get notes => noteList.toList();

  @override
  void onInit() {
    super.onInit();
    // Mendapatkan uid dari AuthController
    String? uid = Get.find<AuthController>().user?.uid;

    if (uid != null) {
      // Memuat catatan hanya jika uid tidak null
      noteList.bindStream(Database().noteStream(uid));
    } else {
      print("UID tidak ditemukan, tidak dapat memuat catatan.");
    }
  }
}
