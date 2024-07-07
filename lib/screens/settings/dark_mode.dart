import 'package:flutter/material.dart';
import 'package:flutter_note/screens/settings/widgets/list_tile.dart';
import 'package:flutter_note/screens/widgets/custom_icon_btn.dart';
import 'package:get/get.dart';

class DarkMode extends StatefulWidget {
  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
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
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    Text(
                      "Tampilan",
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
                  Get.changeThemeMode(ThemeMode.system);
                },
                title: "Gunakan Tema Device",
                iconData: Icons.settings_brightness_outlined,
                subtitle: Text(
                  "Automatis mengganti tema Cerah dan Gelap sesuai dengan tema device",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
                textColor: Get.isDarkMode ? Colors.black : Colors.white,
              ),
              ListTileSetting(
                onTap: () {
                  Get.changeThemeMode(ThemeMode.light);
                },
                title: "Tema Cerah",
                iconData: Icons.brightness_5,
                subtitle: SizedBox.shrink(),
                textColor: Get.isDarkMode ? Colors.black : Colors.white,
              ),
              ListTileSetting(
                iconData: Icons.brightness_4_outlined,
                onTap: () {
                  Get.changeThemeMode(ThemeMode.dark);
                },
                title: "Tema Gelap",
                subtitle: SizedBox.shrink(),
                textColor: Get.isDarkMode ? Colors.black : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
