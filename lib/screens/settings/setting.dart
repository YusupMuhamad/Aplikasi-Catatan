import 'package:flutter/material.dart';
import 'package:flutter_note/controllers/authController.dart';
import 'package:flutter_note/screens/settings/account.dart';
import 'package:flutter_note/screens/settings/dark_mode.dart';
import 'package:flutter_note/screens/settings/widgets/list_tile.dart';
import 'package:flutter_note/screens/widgets/custom_icon_btn.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: Column(
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
                      "Pengaturan",
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
              ListTileSetting(
                onTap: () {
                  Get.to(() => Account());
                },
                title: "Akun",
                iconData: Icons.person,
                subtitle: SizedBox.shrink(),
                textColor: Get.isDarkMode ? Colors.black : Colors.white,
              ),
              ListTileSetting(
                onTap: () {
                  Get.to(() => DarkMode());
                },
                title: "Tampilan",
                iconData: Icons.nights_stay,
                subtitle: SizedBox.shrink(),
                textColor: Get.isDarkMode ? Colors.black : Colors.white,
                dividerColor: Theme.of(context).dividerColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
