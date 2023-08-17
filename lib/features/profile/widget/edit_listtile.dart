import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';

class EditListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const EditListTile({super.key, required this.title, required this.subtitle});

  Widget build(BuildContext context) {
    return ListTile(
      title: AppSubtitle(
        value: title,
      ),
      subtitle: AppText(value: subtitle, color: Colors.grey),

    );
  }
}
