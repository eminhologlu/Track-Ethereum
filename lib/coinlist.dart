import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kripto/getEther.dart';

class CoinList extends StatefulWidget {
  const CoinList({super.key});

  @override
  State<CoinList> createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  late String priceusd;
  late String pricebtc;
  String nodes = "";
  late Timer timer;
  int countdown = 10;
  @override
  void initState() {
    super.initState();
    pricebtc = "";
    updateStats();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        updateStats();
        countdown = 10;
      }
    });
  }

  Future<void> updateStats() async {
    try {
      final String priceB = await getPriceBTC();
      final String priceU = await getPriceUSD();
      final String node = await getNodesCount();
      if (!mounted) return;
      setState(() {
        pricebtc = priceB;
        priceusd = priceU;
        nodes = node;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 58, 65),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Ethereum Stats",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                child: Text(
                  'Next update in $countdown s',
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 231, 209, 13)),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 4, 58, 65)),
                width: MediaQuery.of(context).size.height * 0.4,
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ether Price',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 231, 209, 13)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: pricebtc.isEmpty
                          ? CircularProgressIndicator(
                              color: Color.fromARGB(255, 4, 58, 65),
                              strokeWidth: 3,
                            )
                          : Text(
                              '$pricebtc btc\n\n$priceusd usd',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 4, 58, 65),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              width: MediaQuery.of(context).size.height * 0.4,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Nodes Count',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 231, 209, 13)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: nodes.isEmpty
                          ? CircularProgressIndicator(
                              color: Color.fromARGB(255, 4, 58, 65),
                              strokeWidth: 3,
                            )
                          : Text(
                              '$nodes nodes',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 4, 58, 65),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              width: MediaQuery.of(context).size.height * 0.4,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
          ],
        ),
      ),
    );
  }
}
