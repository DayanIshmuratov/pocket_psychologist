import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/animations/expanded_section.dart';

import '../../../constants/app_colors/app_theme.dart';

class AppThemeSwitcher extends StatefulWidget {
  @override
  State<AppThemeSwitcher> createState() {
    return _AppThemeSwitcherState();
  }
}

class _AppThemeSwitcherState extends State<AppThemeSwitcher> {
  bool _isExpanded = false;

  void _toogleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    final appTheme = context.read<AppTheme>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(40),
            // shape: BoxShape.circle,
          ),
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  _toogleExpand();
                },
                icon: const Icon(
                  Icons.palette,
                  color: Colors.white,
                ),
              ),
              ExpandedSection(
                expand: _isExpanded,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          appTheme.changeToPurple();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration:  BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.indigo,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          appTheme.changeToGreen();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
