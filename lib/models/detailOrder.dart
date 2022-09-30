import 'dart:convert';

import 'package:flutter_ecoshops/models/product.dart';

class DetailOrder {
  DetailOrder({
    required this.amount,
    required this.finalPrice,
    required this.idProduct,
    this.product,
    this.id,
  });

  int amount;
  int finalPrice;
  String idProduct;
  Product? product;
  String? id;

  factory DetailOrder.fromJson(String str) =>
      DetailOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailOrder.fromMap(Map<String, dynamic> json) => DetailOrder(
        amount: json["amount"],
        finalPrice: json["final_price"],
        idProduct: json["id_product"],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "final_price": finalPrice,
        "id_product": idProduct,
      };
}
