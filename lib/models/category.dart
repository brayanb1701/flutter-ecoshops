import 'dart:convert';

class Category {
  Category({
    this.iconName,
    required this.nameCategory,
    this.id,
  });

  String? iconName;
  String nameCategory;
  String? id;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        iconName: json["icon_name"],
        nameCategory: json["name_category"],
      );

  Map<String, dynamic> toMap() => {
        "icon_name": iconName,
        "name_category": nameCategory,
      };
}
