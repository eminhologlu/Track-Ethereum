import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kripto/coinlist.dart';
import 'package:kripto/gasprice.dart';
import 'package:kripto/settings.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final screens = [
    Settings(),
    CoinList(),
    GasPrice(),
  ];
  final items = [
    Icon(Icons.settings),
    Icon(Icons.query_stats_rounded),
    Icon(Icons.gas_meter_rounded)
  ];
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
              body: screens[currentIndex],
              backgroundColor: const Color.fromARGB(255, 4, 58, 65),
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                items: items,
                index: currentIndex,
                onTap: (index) => setState(() => currentIndex = index),
                height: 60,
                animationDuration: Duration(milliseconds: 450),
              )),
        ),
      ),
    );
  }
}
