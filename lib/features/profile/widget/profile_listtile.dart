import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';

class ProfileListTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const ProfileListTile({super.key, required this.title, required this.icon});

  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return ListTile(
      title: AppSubtitle(
        value: title,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration:
            BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
        child: Icon(icon, color: color),
      ),
      trailing: Icon(Icons.navigate_next),
    );
  }
}
