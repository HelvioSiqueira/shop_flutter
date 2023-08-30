import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/cart_item.dart';
import 'package:shop/utils/constants.dart';

import 'cart.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    _items.clear();

    final response =
        await http.get(Uri.parse("${Constants.ORDER_BASE_URL}.json"));

    if (response.body == "null") return;

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((orderId, orderData) {
      List<dynamic> products = orderData["products"];

      _items.add(Order(
          id: orderId,
          total: orderData["total"],
          products: products
              .map((product) => CartItem(
                  id: product["id"],
                  productId: product["productId"],
                  name: product["name"],
                  quantity: int.parse(product["quantity"].toString()),
                  price: product["price"]))
              .toList(),
          date: DateTime.parse(orderData["date"])));
    });

    notifyListeners();
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
                        "quantity": cartItem.quantity,
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
