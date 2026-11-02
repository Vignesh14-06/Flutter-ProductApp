import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductData {
  static const String baseUrl = 'https://dummyjson.com/products';
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final productsJson = data['products'];
      return productsJson
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
