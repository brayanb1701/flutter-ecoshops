import 'dart:convert';

class Entrepreneurship {
  Entrepreneurship({
    required this.beOnKit,
    required this.commission,
    required this.descpEmp,
    required this.entrepreneurshipName,
    required this.idUser,
    required this.logo,
    this.maxDiscount,
    this.minDiscount,
    this.rawMaterials,
    this.userSocialMedia,
    this.id,
  });

  bool beOnKit;
  int commission;
  String descpEmp;
  String entrepreneurshipName;
  String idUser;
  String logo;
  String? maxDiscount;
  String? minDiscount;
  String? rawMaterials;
  String? userSocialMedia;
  String? id;

  factory Entrepreneurship.fromJson(String str) =>
      Entrepreneurship.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Entrepreneurship.fromMap(Map<String, dynamic> json) =>
      Entrepreneurship(
        beOnKit: json["be_on_kit"],
        commission: json["commission"],
        descpEmp: json["descp_emp"],
        entrepreneurshipName: json["entrepreneurship_name"],
        idUser: json["id_user"],
        logo: json["logo"],
        maxDiscount: json["max_discount"],
        minDiscount: json["min_discount"],
        rawMaterials: json["raw_materials"],
        userSocialMedia: json["user_social_media"],
      );

  Map<String, dynamic> toMap() => {
        "be_on_kit": beOnKit,
        "commission": commission,
        "descp_emp": descpEmp,
        "entrepreneurship_name": entrepreneurshipName,
        "id_user": idUser,
        "logo": logo,
        "max_discount": maxDiscount,
        "min_discount": minDiscount,
        "raw_materials": rawMaterials,
        "user_social_media": userSocialMedia,
      };
}
