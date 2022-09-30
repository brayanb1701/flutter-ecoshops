import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/constants.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:flutter_ecoshops/services/order_service.dart';
import 'package:flutter_ecoshops/widgets/widgets.dart';
import 'package:flutter_ecoshops/services/categories_services.dart';
import 'package:flutter_ecoshops/src/pages/product_detail/details_screen.dart';
import 'package:provider/provider.dart';

import 'item_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categoriesServices = Provider.of<CategoriesService>(context);
    final orderServices = Provider.of<OrderService>(context);
    List<String> categories = categoriesServices.categories.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text("Kit 1", style: Theme.of(context).textTheme.headline5
              // .copyWith(fontWeight: FontWeight.bold),
              ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("product")
                  .where('category_prod', isEqualTo: categories[selectedIndex])
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('No products yet...');
                } else {
                  return GridView.builder(
                      itemCount: snapshot.data!.size,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: kDefaultPaddin,
                        crossAxisSpacing: kDefaultPaddin,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        var ref = snapshot.data!.docs[index];
                        var newProduct =
                            new Product.fromMap((ref.data() as dynamic));
                        newProduct.id = ref.id;
                        return ItemCard(
                          product: newProduct,
                        );
                      });
                }
              },
            ),
          ),
        ),
        Center(
          child: RoundedButton(
            buttonName: 'Agregar al Carrito',
            onPressed: () async {
              var prods = await FirebaseFirestore.instance
                  .collection("product")
                  .where("category_prod", isEqualTo: "Aseo")
                  .get();
              await Future.forEach(prods.docs, (QueryDocumentSnapshot element) {
                var newProd = Product.fromMap(element.data() as dynamic);
                newProd.id = element.id;
                newProd.price = (newProd.price * 0.9).toInt();
                orderServices.addDetail(element.id, 1, newProd);
              });
              Navigator.pushNamed(context, '/');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("El kit se ha agregado al carrito!"),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.lightGreen,
              ));
            },
          ),
        ),
      ],
    );
  }

  Widget buildCategory(int index, List<String> categories) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
