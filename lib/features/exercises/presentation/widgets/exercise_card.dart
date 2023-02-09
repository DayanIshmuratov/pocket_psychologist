import 'package:flutter/material.dart';
class ExerciseCard extends StatelessWidget {
  final String title;
  final String image;
  final String page;
  const ExerciseCard({Key? key, required this.title, required this.page, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, page);
      },
      child: Card(
        child: Column(
           children: [
             Image.asset(image),
             Text(title),
           ],
         )
      ),
    );
  }
}
