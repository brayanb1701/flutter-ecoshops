import 'dart:convert';

class Donation {
  Donation({
    required this.address,
    required this.description,
    required this.email,
    required this.idEntrepreneurship,
    this.id,
  });

  String address;
  String description;
  String email;
  String idEntrepreneurship;
  String? id;

  factory Donation.fromJson(String str) => Donation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Donation.fromMap(Map<String, dynamic> json) => Donation(
        address: json["address"],
        description: json["description"],
        email: json["email"],
        idEntrepreneurship: json["id_entrepreneurship"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "description": description,
        "email": email,
        "id_entrepreneurship": idEntrepreneurship,
      };
}
