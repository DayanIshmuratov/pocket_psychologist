
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главное меню'),
        centerTitle: true,
      ),
      body: const Center(child:  Text('Soon..')),
    );
  }
}
