import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/product.dart';
import 'package:flutter_ecoshops/constants.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        product.descp,
        style: TextStyle(height: 1.5),
      ),
    );
  }
}
