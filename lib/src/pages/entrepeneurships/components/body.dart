import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/constants.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:flutter_ecoshops/services/categories_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ecoshops/services/services.dart';
import 'package:flutter_ecoshops/models/entrepreneurship.dart';
//import '../../profile/components/profile_menu.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  @override
  const Body({Key? key, required this.id}) : super(key: key);
  final String id;
  _BodyState createState() => _BodyState();
}

const Color black = Color(0xff000000);
const Color white = Color(0xffffffff);
const Color blue = Color(0xff0D47A1);
const Color grey = Color(0xffbdbdbd);
const Color lineWhite = Color(0xffececec);
const Color lineGrey = Color(0xffbdbdbd);
const Color lineTextGrey = Color(0xff9E9E9E);

class _BodyState extends State<Body> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categoriesServices = Provider.of<CategoriesService>(context);
    final entServices = Provider.of<EntrepreneurshipService>(context);
    final Future<Entrepreneurship> profile = entServices.getProfile(widget.id);
    List<String> categories = categoriesServices.categories.keys.toList();

    return FutureBuilder(
        future: profile,
        builder:
            (BuildContext context, AsyncSnapshot<Entrepreneurship> snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/eukarya_logo.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.entrepreneurshipName,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Miembro desde el 2021",
                            style: TextStyle(
                                fontSize: 15, color: black.withOpacity(0.7)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF9DBE76),
                                borderRadius: BorderRadius.circular(5)),
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, 'donate_material',
                                  arguments: {"id_ent": snapshot.data!.id}),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Text(
                                    "Donar Materia Prima",
                                    style:
                                        TextStyle(fontSize: 18, color: white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: Text("Productos",
                      style: Theme.of(context).textTheme.headline5
                      // .copyWith(fontWeight: FontWeight.bold),
                      ),
                ),
                Expanded(
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
                )
              ],
            );
          } else {
            return Text("No data found.");
          }
        });
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
