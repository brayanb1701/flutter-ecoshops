import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/constants.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:flutter_ecoshops/widgets/widgets.dart';
import 'package:flutter_ecoshops/services/categories_services.dart';
import 'package:flutter_ecoshops/src/pages/product_detail/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ecoshops/services/services.dart';
import 'package:flutter_ecoshops/models/entrepreneurship.dart';

import 'item_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthService>(context);
    final entServices = Provider.of<EntrepreneurshipService>(context);
    final Future<Entrepreneurship> profile =
        entServices.getProfileByUserId(authServices.currentUser.id!);
    final categoriesServices = Provider.of<CategoriesService>(context);
    List<String> categories = categoriesServices.categories.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child:
              Text("Mis Productos", style: Theme.of(context).textTheme.headline5
                  // .copyWith(fontWeight: FontWeight.bold),
                  ),
        ),
        FutureBuilder(
            future: profile,
            builder: (BuildContext context,
                AsyncSnapshot<Entrepreneurship> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("product")
                          .where('id_entrepreneurship',
                              isEqualTo: snapshot.data!.id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('No products yet...');
                        } else {
                          return GridView.builder(
                              itemCount: snapshot.data!.size,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: kDefaultPaddin,
                                crossAxisSpacing: kDefaultPaddin,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) {
                                var ref = snapshot.data!.docs[index];
                                var newProduct = new Product.fromMap(
                                    (ref.data() as dynamic));
                                newProduct.id = ref.id;
                                return ItemCard(
                                  product: newProduct,
                                );
                              });
                        }
                      },
                    ),
                  ),
                );
              } else {
                return Text("No data found.");
              }
            }),
        Center(
          child: RoundedButton(
            buttonName: 'Agregar Producto',
            onPressed: () {
              Navigator.pushNamed(context, 'register_product');
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
