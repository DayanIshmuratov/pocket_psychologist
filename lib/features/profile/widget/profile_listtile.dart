import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';

class ProfileListTile extends StatelessWidget {
  final String text;
  final IconData icon;

  const ProfileListTile({super.key, required this.text, required this.icon});

  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return ListTile(
      title: AppSubtitle(
        value: text,
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
