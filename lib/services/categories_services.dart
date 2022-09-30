import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, String> categories = {};
  late CollectionReference _categories;

  bool isLoading = false;

  CategoriesService() {
    this._categories = _firestore.collection('category');
    this.loadCategories();
    sleep(Duration(seconds: 3));
  }

  Future loadCategories() async {
    await _categories
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs.forEach((doc) {
              var name = (doc.data() as dynamic)["name_category"];
              var icon = (doc.data() as dynamic)["icon_name"];
              categories[name] = icon;
            }));
  }
}
