import 'package:flutter/material.dart';
import 'package:flutter_note/controllers/authController.dart';
import 'package:flutter_note/controllers/noteController.dart';
import 'package:flutter_note/screens/auth/login.dart';
import 'package:flutter_note/screens/home/add_note.dart';
import 'package:flutter_note/screens/home/note_list.dart';
import 'package:flutter_note/screens/settings/setting.dart';
import 'package:flutter_note/screens/widgets/custom_icon_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthController authController = Get.find<AuthController>();
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            authController.setUserEmail(snapshot.data!.email!);

            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconBtn(
                            color: Theme.of(context).colorScheme.background,
                            onPressed: () {
                              setState(() {
                                authController.axisCount.value =
                                    authController.axisCount.value == 2 ? 4 : 2;
                              });
                            },
                            icon: Icon(authController.axisCount.value == 2
                                ? Icons.list
                                : Icons.grid_on),
                          ),
                          Text(
                            "Notes",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          CustomIconBtn(
                            color: Theme.of(context).colorScheme.background,
                            onPressed: () {
                              Get.to(() => Setting());
                            },
                            icon: Icon(Icons.settings),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Obx(() {
                          if (noteController.notes.isNotEmpty) {
                            return NoteList();
                          } else {
                            return Text("Catatan kosong, ayo buat!");
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.background,
                tooltip: "Add Note",
                onPressed: () {
                  Get.to(() => AddNotePage());
                },
                child: Icon(Icons.note_add, size: 30),
              ),
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.offAll(() => Login());
            });
            return SizedBox();
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
