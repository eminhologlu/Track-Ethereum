import 'package:flutter/material.dart';
import 'package:kripto/anasayfa.dart';

void main() {
  runApp(const Kripto());
}

class Kripto extends StatelessWidget {
  const Kripto({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnaSayfa(),
    );
  }
}
