import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getStats() async {
  final String apiUrl =
      'https://api.etherscan.io/api?module=stats&action=ethprice&apikey=APIKEY';

  try {
    final http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['result'];
    } else {
      print('HTTP Error: ${response.statusCode}');
      return {};
    }
  } catch (error) {
    print('Error: $error');
    return {};
  }
}

Future<Map<String, dynamic>> getStats2() async {
  final String apiUrl =
      'https://api.etherscan.io/api?module=stats&action=nodecount&apikey=APIKEY';

  try {
    final http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['result'];
    } else {
      print('HTTP Error: ${response.statusCode}');
      return {};
    }
  } catch (error) {
    print('Error: $error');
    return {};
  }
}

Future<String> getPriceBTC() async {
  final Map<String, dynamic> data = await getStats();
  String ethPriceString = data['ethbtc'].substring(0, 7);
  return ethPriceString;
}

Future<String> getPriceUSD() async {
  final Map<String, dynamic> data = await getStats();
  String ethPriceString = data['ethusd'].substring(0, 7);
  return ethPriceString;
}

Future<String> getNodesCount() async {
  final Map<String, dynamic> data = await getStats2();
  return data['TotalNodeCount'];
}
