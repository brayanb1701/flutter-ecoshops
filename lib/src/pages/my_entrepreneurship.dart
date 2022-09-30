import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/entrepreneurship.dart';
import 'package:flutter_ecoshops/services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_ecoshops/constants.dart';
import 'package:provider/provider.dart';
import 'profile/components/profile_menu.dart';

class EntrepreneurPage extends StatefulWidget {
  @override
  MyEntrepreneurship createState() => MyEntrepreneurship();
}

class MyEntrepreneurship extends State<EntrepreneurPage> {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthService>(context);
    final entServices = Provider.of<EntrepreneurshipService>(context);
    final Future<Entrepreneurship> profile =
        entServices.getProfileByUserId(authServices.currentUser.id!);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text("Emprendimiento"),
      ),
      body: getBody(profile),
    );
  }

  List accountList = [
    "Mis productos",
    "Registrar producto",
    "Notifications",
    "Delivery Information",
    "Payment Information",
    "Language",
    "Privacy Settings"
  ];

  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);
  static const Color blue = Color(0xff0D47A1);
  static const Color grey = Color(0xffbdbdbd);
  static const Color lineWhite = Color(0xffececec);
  static const Color lineGrey = Color(0xffbdbdbd);
  static const Color lineTextGrey = Color(0xff9E9E9E);

  Widget getBody(Future<Entrepreneurship> profile) {
    return FutureBuilder(
        future: profile,
        builder:
            (BuildContext context, AsyncSnapshot<Entrepreneurship> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
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
                            snapshot.data!.descpEmp,
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
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Text(
                                  "Editar Información",
                                  style: TextStyle(fontSize: 15, color: white),
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
                ProfileMenu(
                  text: "Ventas",
                  icon: "assets/icons/shop.svg",
                  press: () {
                    Navigator.pushNamed(context, 'sales',
                        arguments: {"id_ent": snapshot.data!.id});
                  },
                ),
                ProfileMenu(
                  text: "Mis Productos",
                  icon: "assets/icons/gift.svg",
                  press: () {
                    Navigator.pushNamed(context, 'my_products');
                  },
                ),
                ProfileMenu(
                  text: "Oferta de Materia Prima",
                  icon: "assets/icons/check.svg",
                  press: () {
                    Navigator.pushNamed(context, 'oferta');
                  },
                ),
              ],
            );
          } else {
            return Text("No data found.");
          }
        });
  }
}
