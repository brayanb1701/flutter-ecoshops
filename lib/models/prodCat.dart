import 'dart:convert';

class ProdCat {
  ProdCat({
    required this.idCat,
    required this.idProduct,
    this.id,
  });

  int idCat;
  int idProduct;
  String? id;

  factory ProdCat.fromJson(String str) => ProdCat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProdCat.fromMap(Map<String, dynamic> json) => ProdCat(
        idCat: json["id_cat"],
        idProduct: json["id_product"],
      );

  Map<String, dynamic> toMap() => {
        "id_cat": idCat,
        "id_product": idProduct,
      };
}
