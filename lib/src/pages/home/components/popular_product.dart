import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/components/product_card.dart';
import 'package:flutter_ecoshops/models/product.dart';

import 'package:flutter_ecoshops/size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("product").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text(
            'No products yet...',
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child:
                    SectionTitle(title: "Productos Destacados", press: () {}),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...snapshot.data!.docs.map((doc) {
                      var newProduct =
                          new Product.fromMap((doc.data() as dynamic));
                      newProduct.id = doc.id;
                      return ProductCard(product: newProduct);
                    }).toList(),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ),
              )
            ],
          );
        }
      },
    );
  }
}
