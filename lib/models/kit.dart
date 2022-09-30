import 'dart:convert';

class Kit {
  Kit({
    required this.discount,
    required this.kitName,
    required this.price,
    this.id,
  });

  int discount;
  String kitName;
  int price;
  String? id;

  factory Kit.fromJson(String str) => Kit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Kit.fromMap(Map<String, dynamic> json) => Kit(
        discount: json["discount"],
        kitName: json["kit_name"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "discount": discount,
        "kit_name": kitName,
        "price": price,
      };
}
