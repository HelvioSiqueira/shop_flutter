import 'package:flutter/material.dart';

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

  void toggleFavorite(){
    isFavorite = !isFavorite;
    notifyListeners();
  }

  @override
  String toString() {
    return "$id | $name | $description | $price | $imageUrl";
  }
}
