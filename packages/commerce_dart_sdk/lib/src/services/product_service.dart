import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/models.dart';

Future<List<Product>> getProducts() async {
  var headers = {
    'Cookie':
        'CurrentCurrencyId=30b432b9-a104-e511-96f5-ac9e17867f77; CurrentLanguageId=a26095ef-c714-e311-ba31-d43d7e4e88b2; InsiteCacheId=28ba8f65-1019-4d99-a077-95af571cdde0; SetContextLanguageCode=en-us; SetContextPersonaIds=d06988c0-9358-4dbb-aa3d-b7be5b6a7fd9'
  };

  var request = http.Request(
      'GET',
      Uri.parse(
          'https://mobilespire.commerce.insitesandbox.com/api/v1/products'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(await response.stream.bytesToString());
    var productList = List<Product>.from(
        jsonResponse['products'].map((x) => Product.fromJson(x)));
    return productList;
  } else {
    return [];
  }
}
