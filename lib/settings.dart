import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 58, 65),
      body: Center(
        child: Text(
          "SETTINGS PAGE",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
        ),
      ),
    );
  }
}
