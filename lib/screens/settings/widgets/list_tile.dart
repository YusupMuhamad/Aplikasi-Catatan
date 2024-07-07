import 'package:flutter/material.dart';

class ListTileSetting extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final IconData iconData;
  final Widget subtitle;
  final Color textColor;
  final Color dividerColor; // Added this line

  ListTileSetting({
    required this.title,
    required this.iconData,
    required this.onTap,
    required this.subtitle,
    required this.textColor,
    this.dividerColor = Colors.grey, // Added this line with a default value
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
          ),
          onTap: onTap,
          leading: Icon(
            iconData,
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text(
            title,
            style: TextStyle(color: textColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).iconTheme.color,
          ),
          subtitle: subtitle,
        ),
        Divider(
          indent: 60,
          thickness: 2,
          color: dividerColor, // Use dividerColor here
        ),
      ],
    );
  }
}
