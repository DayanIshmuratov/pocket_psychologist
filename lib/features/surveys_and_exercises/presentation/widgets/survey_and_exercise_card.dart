import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';

import '../../../../common/animations/expanded_section.dart';

class SurveyAndExerciseCard extends StatefulWidget {
  final String title;
  final String image;
  final String description;
  final String page;

  const SurveyAndExerciseCard(
      {Key? key,
        required this.title,
        required this.page,
        required this.image,
        required this.description})
      : super(key: key);

  @override
  State<SurveyAndExerciseCard> createState() => _SurveyAndExerciseCardState();
}

class _SurveyAndExerciseCardState extends State<SurveyAndExerciseCard> {
  bool _isExpanded = false;

  void _toogleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4.0,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    AppTitle(value: widget.title.toUpperCase()),
                    Divider(thickness: 1.0),
                    GestureDetector(
                      onTap: _toogleExpand,
                        child: AppSubtitle(value: 'Описание',)),
                    ExpandedSection(
                      expand: _isExpanded,
                      child: AppSubtitle(
                          value: widget.description),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, widget.page);
                      },
                      child: AppSubtitle(
                        value: 'Приступить',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
