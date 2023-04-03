import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';

class ProfileCard extends StatelessWidget {
  final String text;

  const ProfileCard({super.key, required this.text});
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppSubtitle(value: text),
        ),
      ),
    );
  }
}