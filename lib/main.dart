import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/counter_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_details_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/utils/app_routes.dart';

import 'models/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList())
      ],
      child: MaterialApp(
          routes: {
            AppRoutes.HOME: (context) => const ProductsOverviewPage(),
            AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
            AppRoutes.CART: (context) => const CartPage(),
            AppRoutes.ORDERS: (context) => const OrdersPage(),
            AppRoutes.PRODUCTS: (context) => const ProductsPage(),
            AppRoutes.PRODUCT_FORM: (context) => const ProductFormPage(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                    fontFamily: 'Lato', fontSize: 14, color: Colors.black),
                titleMedium: TextStyle(fontFamily: 'Lato', fontSize: 20),
              ),
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.purple,
                  primary: Colors.purple,
                  secondary: Colors.deepOrange),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white),
                  color: Colors.purple,
                  titleTextStyle: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'Lato')))),
    );
  }
}
