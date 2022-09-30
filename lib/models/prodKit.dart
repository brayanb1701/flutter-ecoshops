// To parse this JSON data, do
//
//     final prodKit = prodKitFromMap(jsonString);

import 'dart:convert';

class ProdKit {
  ProdKit({
    required this.idKit,
    required this.idProduct,
    this.id,
  });

  int idKit;
  int idProduct;
  String? id;

  factory ProdKit.fromJson(String str) => ProdKit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProdKit.fromMap(Map<String, dynamic> json) => ProdKit(
        idKit: json["id_kit"],
        idProduct: json["id_product"],
      );

  Map<String, dynamic> toMap() => {
        "id_kit": idKit,
        "id_product": idProduct,
      };
}
