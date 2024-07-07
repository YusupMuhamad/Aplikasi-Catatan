import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/controllers/userController.dart';
import 'package:flutter_note/models/user.dart';
import 'package:flutter_note/services/database.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Menambahkan RxString untuk menyimpan email pengguna secara reaktif
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _firebaseUser = Rx<User>(user); // Inisialisasi _firebaseUser
        setUserEmail(user.email!); // Set email ketika pengguna terdeteksi
      } else {
        setUserEmail(''); // Kosongkan email jika tidak ada pengguna
      }
    });
  }

  late Rx<User?> _firebaseUser;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel(id: '', email: '').obs;
  Rx<int> axisCount = 2.obs;

  User? get user {
    return _firebaseUser.value;
  }

  // Fungsi untuk mengatur email pengguna
  void setUserEmail(String email) {
    userEmail.value = email;
  }

  void createUser() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) {
        UserModel _user = UserModel(
          id: value.user!.uid,
          email: email.text,
        );
        Database().createNewUser(_user).then((value) {
          if (value) {
            Get.find<UserController>().user = _user;
            Get.back();
            _clearControllers();
          }
        });
      });
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login() async {
    try {
      print("IN logging in email ${email.text} password ${password.text}");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      String? userId = userCredential.user?.uid;

      if (userId != null) {
        UserModel? fetchedUser = await Database().getUser(userId);
        if (fetchedUser != null) {
          Get.find<UserController>().user = fetchedUser;
        } else {
          Get.snackbar(
            'Error',
            'No user found',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'User ID is null',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      _clearControllers();
    } catch (e) {
      Get.snackbar(
        'Error logging in',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signout() async {
    try {
      await _auth.signOut();
      Get.find<UserController>().user = UserModel(id: '', email: '');
      setUserEmail(''); // Kosongkan email saat sign out
    } catch (e) {
      Get.snackbar(
        'Error signing out',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Fungsi untuk mengganti password pengguna
  Future<bool> changePassword(String newPassword) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
      return true;
    } catch (e) {
      print("Error changing password: $e");
      return false;
    }
  }

  Future<bool> verifyOldPassword(String oldPassword) async {
    User? currentUser = _auth.currentUser;
    String? email = currentUser?.email;

    if (email != null) {
      try {
        // Mencoba autentikasi ulang dengan email dan password lama
        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: oldPassword);
        await currentUser!.reauthenticateWithCredential(credential);
        return true; // Password lama benar
      } catch (e) {
        return false; // Password lama salah atau terjadi kesalahan lain
      }
    }
    return false; // Email tidak tersedia, tidak dapat memverifikasi
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Email Reset Dikirim",
        "Silakan cek email Anda untuk instruksi lebih lanjut",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Kesalahan Email Reset",
        "Tidak dapat mengirim email reset: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void sendErrorMessage(String message) {
    Get.snackbar(
      "Kesalahan",
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  _clearControllers() {
    email.clear();
    password.clear();
  }
}
