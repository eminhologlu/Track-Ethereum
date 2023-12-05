import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kripto/getGas.dart';

class GasPrice extends StatefulWidget {
  const GasPrice({super.key});

  @override
  State<GasPrice> createState() => _GasPriceState();
}

class _GasPriceState extends State<GasPrice> {
  late Map<String, dynamic> gasPrices;
  late Timer timer;
  int countdown = 15;

  @override
  void initState() {
    super.initState();
    gasPrices = {};
    updateGasPrices(); // Sayfa oluşturulduğunda hemen güncelle

    // Timer'ı başlat ve her 10 saniyede bir güncelleme yap
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        updateGasPrices();
        countdown = 15; // Yeniden başlat
      }
    });
  }

  Future<void> updateGasPrices() async {
    try {
      final Map<String, dynamic> data = await getGasPrices();
      if (!mounted) return; // State henüz dispose edilmediyse devam et
      setState(() {
        gasPrices = data;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    timer.cancel(); // Timer'ı dispose etmek önemlidir.
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
                "Ethereum Gas Tracker",
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
                      'Low',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 231, 209, 13)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: gasPrices.isEmpty
                          ? CircularProgressIndicator(
                              color: Color.fromARGB(255, 4, 58, 65),
                              strokeWidth: 3,
                            ) // Loading animasyonu
                          : Text(
                              '${gasPrices['SafeGasPrice']} gwei',
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
              height: MediaQuery.of(context).size.height * 0.17,
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
                      'Average',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 231, 209, 13)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: gasPrices.isEmpty
                          ? CircularProgressIndicator(
                              color: Color.fromARGB(255, 4, 58, 65),
                              strokeWidth: 3,
                            ) // Loading animasyonu
                          : Text(
                              '${gasPrices['ProposeGasPrice']} gwei',
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
              height: MediaQuery.of(context).size.height * 0.17,
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
                      'High',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 231, 209, 13)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: gasPrices.isEmpty
                          ? CircularProgressIndicator(
                              color: Color.fromARGB(255, 4, 58, 65),
                              strokeWidth: 3,
                            ) // Loading animasyonu
                          : Text(
                              '${gasPrices['FastGasPrice']} gwei',
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
              height: MediaQuery.of(context).size.height * 0.17,
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
                      'Last Block',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 231, 209, 13)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: gasPrices.isEmpty
                          ? CircularProgressIndicator(
                              color: Color.fromARGB(255, 4, 58, 65),
                              strokeWidth: 3,
                            ) // Loading animasyonu
                          : Text(
                              '${gasPrices['LastBlock']}',
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
              height: MediaQuery.of(context).size.height * 0.17,
            ),
          ],
        ),
      ),
    );
  }
}
