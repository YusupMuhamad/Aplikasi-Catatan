import 'package:flutter/material.dart';
import 'package:flutter_note/controllers/authController.dart';
import 'package:flutter_note/controllers/userController.dart';
import 'package:flutter_note/screens/widgets/custom_icon_btn.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  Account() {
    Get.put(UserController());
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomIconBtn(
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                      color: Theme.of(context).colorScheme.background,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    Text(
                      "Akun",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Obx(
                  () => RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hi, ini adalah menu akun! \n",
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        WidgetSpan(
                            child: Icon(
                              Icons.email,
                              size: 20,
                            ),
                            alignment: PlaceholderAlignment.middle),
                        WidgetSpan(
                          child: SizedBox(height: 25),
                        ),
                        TextSpan(
                          text: " ${authController.userEmail}",
                          style: TextStyle(
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                onTap: () {
                  showChangePasswordDialog(context);
                },
                title: Text(
                  "Ganti Password",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
                leading: Icon(
                  Icons.lock_outline,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                onTap: () {
                  showSignOutDialog(context);
                },
                title: Text(
                  "Logout",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
                leading: Icon(
                  Icons.power_settings_new_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSignOutDialog(BuildContext context) async {
  final AuthController authController = Get.find<AuthController>();
  print("in dialog ");
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(20),
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        title: Text(
          "Apakah benar ingin keluar?",
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Tidak usah khawatir, semua catatan akan tersimpan selagi kamu masuk ke akun yang sama.',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonMinWidth: 90,
            children: <Widget>[
              ElevatedButton(
                child: Text("Keluar",
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  Get.snackbar(
                    "Terimakasih",
                    "Kami akan menunggu anda kembali...",
                    snackPosition: SnackPosition.TOP,
                  );
                  Future.delayed(Duration(seconds: 2), () {
                    Get.back();
                    authController.signout();
                    Get.close(2);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent.shade700,
                ),
              ),
              TextButton(
                child: Text("Kembali",
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.black : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}

void showChangePasswordDialog(BuildContext context) {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _obscureTextOldPassword = true;
  bool _obscureTextPassword = true;
  bool _obscureTextConfirm = true;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          title: Text("Ganti Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                  labelText: "Password Lama",
                  hintText: "Masukkan password lama",
                  labelStyle: TextStyle(
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                    fontSize: 16,
                  ),
                  hintStyle: TextStyle(
                    color: Get.isDarkMode
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white.withOpacity(0.5),
                    fontSize: 10,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Get.isDarkMode ? Colors.black : Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Get.isDarkMode ? Colors.black : Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: Opacity(
                      opacity: 0.5,
                      child: Icon(
                        _obscureTextOldPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureTextOldPassword = !_obscureTextOldPassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscureTextOldPassword,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password Baru",
                  hintText: "Masukkan password baru",
                  labelStyle: TextStyle(
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                    fontSize: 16,
                  ),
                  hintStyle: TextStyle(
                    color: Get.isDarkMode
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white.withOpacity(0.5),
                    fontSize: 10,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Get.isDarkMode ? Colors.black : Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Get.isDarkMode ? Colors.black : Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: Opacity(
                      opacity: 0.5,
                      child: Icon(
                        _obscureTextPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureTextPassword = !_obscureTextPassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscureTextPassword,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Konfirmasi Password",
                  hintText: "Masukkan kembali password baru",
                  labelStyle: TextStyle(
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                    fontSize: 16,
                  ),
                  hintStyle: TextStyle(
                    color: Get.isDarkMode
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white.withOpacity(0.5),
                    fontSize: 10,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Get.isDarkMode ? Colors.black : Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Get.isDarkMode ? Colors.black : Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: Opacity(
                      opacity: 0.5,
                      child: Icon(
                        _obscureTextConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureTextConfirm = !_obscureTextConfirm;
                      });
                    },
                  ),
                ),
                obscureText: _obscureTextConfirm,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Batal",
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Simpan",
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                ),
              ),
              onPressed: () async {
                if (passwordController.text == confirmPasswordController.text) {
                  try {
                    AuthController authController = Get.find<AuthController>();
                    bool isOldPasswordCorrect = await authController
                        .verifyOldPassword(oldPasswordController.text);
                    if (isOldPasswordCorrect) {
                      bool result = await authController
                          .changePassword(passwordController.text);
                      if (result) {
                        Get.snackbar(
                          "Sukses",
                          "Password berhasil diganti",
                          snackPosition: SnackPosition.TOP,
                        );
                        Navigator.of(context).pop();
                      } else {
                        Get.snackbar(
                          "Gagal",
                          "Password gagal diganti",
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    } else {
                      Get.snackbar(
                        "Gagal",
                        "Password lama tidak cocok",
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  } catch (e) {
                    print("Error: $e");
                  }
                } else {
                  Get.snackbar(
                    "Gagal",
                    "Password baru tidak cocok",
                    snackPosition: SnackPosition.TOP,
                  );
                }
              },
            ),
          ],
        );
      });
    },
  );
}
