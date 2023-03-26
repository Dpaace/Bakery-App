import 'package:bakey/model/product_model.dart';
import 'package:flutter/material.dart';

import '../../app/constant.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  const ProductWidget({required this.product, super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      shadowColor: Colors.white,
      elevation: 4.0,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.name!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.description!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.weight!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.price!.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                widget.product.image != null
                    ? Image.network(
                        Constant.productImageURL + widget.product.image!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/2.jpg",
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
