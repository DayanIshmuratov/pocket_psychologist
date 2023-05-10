import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';

class EditListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const EditListTile({super.key, required this.title, required this.subtitle});

  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return ListTile(
      title: AppSubtitle(
        value: title,
      ),
      subtitle: AppText(value: subtitle, color: Colors.grey),
      // leading: Container(
      //   width: 40,
      //   height: 40,
      //   decoration:
      //   BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
      //   child: Icon(icon, color: color),
      // ),
    );
  }
}
