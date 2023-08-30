import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/utils/constants.dart';

import 'cart.dart';
import 'order.dart';
import 'package:http/http.dart' as http;

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response =
        await http.post(Uri.parse("${Constants.ORDER_BASE_URL}.json"),
            body: jsonEncode({
              "total": cart.totalAmount,
              "date": date.toIso8601String(),
              "products": cart.items.values
                  .map((cartItem) => {
                        "id": cartItem.id,
                        "productId": cartItem.productId,
                        "name": cartItem.name,
                        "quantyty": cartItem.quantity,
                        "price": cartItem.price,
                      })
                  .toList()
            }));

    var id = jsonDecode(response.body)["name"];

    _items.insert(
        0,
        Order(
            id: id,
            total: cart.totalAmount,
            date: date,
            products: cart.items.values.toList()));

    notifyListeners();
  }
}
