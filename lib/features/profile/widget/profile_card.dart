import 'package:flutter/material.dart';
import 'package:pocket_psychologist/common/components/text.dart';

class ProfileCard extends StatelessWidget {
  final String name;

  ProfileCard({required this.name});

  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Container(
      height: 230,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: color, blurRadius: 1, spreadRadius: 1),
                  ],
                  gradient:
                  LinearGradient(colors: [color, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.12, 1]
                  )
                ),
                height: 130,
              ),
              Column(
                children: [
                  AppTitle(value: 'Профиль', color: Colors.white),
                  SizedBox(height: 32),
                  Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: 'В разработке',
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/no_image.jpg'),
                    ),
                  ),
                  AppSubtitle(value: name),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
