import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';

class ExerciseCard extends StatefulWidget {
  final String title;
  final String image;
  final String description;
  final String page;

  const ExerciseCard(
      {Key? key,
        required this.title,
        required this.page,
        required this.image,
        required this.description})
      : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
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



// import 'package:flutter/material.dart';
// import 'package:pocket_psychologist/common/components/text.dart';
//
// class ExerciseCard extends StatelessWidget {
//   final String title;
//   final String image;
//   final String description;
//   final String page;
//
//   const ExerciseCard(
//       {Key? key,
//       required this.title,
//       required this.page,
//       required this.image,
//       required this.description})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return NestedScrollView(
//           headerSliverBuilder: (context, innerBoxIsScrolled) {
//             return [
//               SliverAppBar(
//               pinned: true,
//               expandedHeight: 100.0,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: AppText(value: title),
//                 background: ClipRRect(
//                   borderRadius: BorderRadius.circular(16.0),
//                   child: AspectRatio(
//                     aspectRatio: 16 / 9,
//                     child: Image.asset(
//                       image,
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             ];
//           },
//           body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 AppTitle(value: title.toUpperCase()),
//                 const Divider(thickness: 1.0),
//                 AppSubtitle(value: description),
//               ],
//             ),
//           ),
//     );
//   }
// }

//

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;

  ExpandedSection(
      {this.expand = false, required this.child});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    Animation<double> curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
