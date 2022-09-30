import 'dart:convert';

class UserProduct {
  UserProduct({
    required this.idProduct,
    required this.idUser,
    required this.saved,
    this.id,
  });

  int idProduct;
  int idUser;
  bool saved;
  String? id;

  factory UserProduct.fromJson(String str) =>
      UserProduct.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserProduct.fromMap(Map<String, dynamic> json) => UserProduct(
        idProduct: json["id_product"],
        idUser: json["id_user"],
        saved: json["saved"],
      );

  Map<String, dynamic> toMap() => {
        "id_product": idProduct,
        "id_user": idUser,
        "saved": saved,
      };
}
