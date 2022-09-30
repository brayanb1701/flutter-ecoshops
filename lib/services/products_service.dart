import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/models.dart';

class ProductsService extends ChangeNotifier {
  final List<Product> products = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _products;
  //late Product selectedProduct;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService();

  Future insertProduct(Map prod) async {
    // Insertar el registro en product
    _products = _firestore.collection("product");
    await _products.doc().set(prod);
  }
}
