import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class Product with ChangeNotifier {
  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    try {
      _toggleFavorite();

      var url = "${Constants.PRODUCT_BASE_URL}/$id.json";
      final response = await http.patch(Uri.parse(url),
          body: jsonEncode(
            {"isFavorite": isFavorite},
          ));

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (error) {
      print(error);
      _toggleFavorite();
    }
  }

  @override
  String toString() {
    return "$id | $name | $description | $price | $imageUrl";
  }
}
