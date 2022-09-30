import 'dart:convert';

class Product {
  Product({
    required this.categoryProd,
    required this.descp,
    required this.idEntrepreneurship,
    required this.images,
    required this.nameProd,
    required this.price,
    required this.stock,
    this.id,
    this.isFavourite = false,
  });

  String? categoryProd;
  String descp;
  String idEntrepreneurship;
  List<dynamic> images;
  String nameProd;
  int price;
  int stock;
  String? id;
  bool isFavourite;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      categoryProd: json["category_prod"],
      descp: json["descp"],
      idEntrepreneurship: json["id_entrepreneurship"],
      images: List<String>.from(json["image"].map((x) => x)),
      nameProd: json["name_prod"],
      price: json["price"],
      stock: json["stock"],
      isFavourite: json["is_favourite"]);

  Map<String, dynamic> toMap() => {
        "category_prod": categoryProd,
        "descp": descp,
        "id_entrepreneurship": idEntrepreneurship,
        "image": List<dynamic>.from(images.map((x) => x)),
        "name_prod": nameProd,
        "price": price,
        "is_favourite": isFavourite,
        "stock": stock,
      };

  Product copy() => Product(
      categoryProd: this.categoryProd,
      descp: this.descp,
      idEntrepreneurship: this.idEntrepreneurship,
      images: this.images,
      nameProd: this.nameProd,
      price: this.price,
      stock: this.stock,
      id: this.id,
      isFavourite: this.isFavourite);
}

List<Product> products = [
  Product(
      id: '1',
      nameProd: "Vasos",
      price: 234,
      descp: dummyText,
      images: ["assets/images/Image Popular Product 2.png"],
      categoryProd: 'Hogar',
      stock: 100,
      isFavourite: true,
      idEntrepreneurship: '1'),
  Product(
      id: '2',
      nameProd: "Belt Bag",
      price: 234,
      descp: dummyText,
      images: ["assets/images/bag_2.png"],
      categoryProd: 'Hogar',
      stock: 100,
      isFavourite: true,
      idEntrepreneurship: '1'),
  Product(
      id: '3',
      nameProd: "Hang Top",
      price: 234,
      descp: dummyText,
      images: ["assets/images/bag_3.png"],
      categoryProd: 'Hogar',
      stock: 100,
      isFavourite: true,
      idEntrepreneurship: '1'),
  Product(
      id: '4',
      nameProd: "Old Fashion",
      price: 234,
      descp: dummyText,
      images: ["assets/images/bag_4.png"],
      categoryProd: 'Hogar',
      stock: 100,
      isFavourite: false,
      idEntrepreneurship: '1'),
  Product(
      id: '5',
      nameProd: "Office Code",
      price: 234,
      descp: dummyText,
      images: ["assets/images/bag_5.png"],
      categoryProd: 'Hogar',
      stock: 100,
      isFavourite: false,
      idEntrepreneurship: '1'),
  Product(
    id: '6',
    nameProd: "Office Code",
    price: 234,
    descp: dummyText,
    images: ["assets/images/bag_6.png"],
    categoryProd: 'Hogar',
    stock: 100,
    idEntrepreneurship: '1',
    isFavourite: false,
  ),
];

List<Product> demoProducts = [
  Product(
    id: "1",
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    nameProd: "Wireless Controller for PS4™",
    price: 65000,
    descp: dummyText,
    isFavourite: true,
    categoryProd: 'Hogar',
    stock: 100,
    idEntrepreneurship: '1',
  ),
  Product(
    id: "2",
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    nameProd: "Nike Sport White - Man Pant",
    price: 505,
    descp: dummyText,
    categoryProd: 'Hogar',
    stock: 100,
    idEntrepreneurship: '1',
  ),
  Product(
    id: "3",
    images: [
      "assets/images/glap.png",
    ],
    nameProd: "Gloves XC Omega - Polygon",
    price: 3655,
    descp: dummyText,
    isFavourite: true,
    categoryProd: 'Hogar',
    stock: 100,
    idEntrepreneurship: '1',
  ),
  Product(
    id: "4",
    images: [
      "assets/images/wireless headset.png",
    ],
    nameProd: "Logitech Head",
    price: 2020,
    descp: dummyText,
    isFavourite: true,
    categoryProd: 'Hogar',
    stock: 100,
    idEntrepreneurship: '1',
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
