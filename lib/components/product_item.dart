import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';

import '../models/product.dart';
import '../utils/app_routes.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.product.imageUrl),
      ),
      title: Text(widget.product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: widget.product,
                );
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Tem certeza"),
                            content: const Text(
                                "Quer remover o item da lista de produtos?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Não")),
                              TextButton(
                                  onPressed: () {
                                    Provider.of<ProductList>(context,
                                            listen: false)
                                        .removeProduct(widget.product.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Sim"))
                            ],
                          ));
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error),
          ],
        ),
      ),
    );
  }
}
