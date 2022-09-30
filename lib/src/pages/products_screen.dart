/*

import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:flutter_ecoshops/services/auth_service.dart';
import 'package:flutter_ecoshops/src/pages/loading_screen.dart';
import 'package:flutter_ecoshops/widgets/product_card.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ecoshops/services/products_service.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text("Productos"),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct =
                productsService.products[index].copy();
            print(productsService.selectedProduct.categoryProd);
            Navigator.pushNamed(context, 'product_form');
          }, //change on tap later
          child: ProductCard(
            product: productsService.products[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          var authServices = Provider.of<AuthService>(context, listen: false);
          authServices.signOut();
          Navigator.pushNamed(context, 'login');

          /*
          productsService.selectedProduct = new Product(
              categoryProd: "0",
              idEntrepreneurship: 0, //Poner ID del emprendimiento
              nameProd: "",
              price: 0,
              stock: 0);
          Navigator.pushNamed(context, 'product_form');
          */
        },
      ),
    );
  }
}
*/