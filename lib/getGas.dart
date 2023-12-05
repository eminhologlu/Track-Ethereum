import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getGasPrices() async {
  final String apiUrl =
      'https://api.etherscan.io/api?module=gastracker&action=gasoracle&apikey=APIKEY';

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
