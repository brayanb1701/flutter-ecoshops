import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_ecoshops/constants.dart';
import '../profile/components/profile_menu.dart';
import "components/body.dart";

class EntrepreneurshipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    print(arguments['id_ent']);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text("Emprendimiento"),
      ),
      body: Body(id: arguments['id_ent']),
    );
  }
}
/*
static const Color black = Color(0xff000000);
static const Color white = Color(0xffffffff);
static const Color blue = Color(0xff0D47A1);
static const Color grey = Color(0xffbdbdbd);
static const Color lineWhite = Color(0xffececec);
static const Color lineGrey = Color(0xffbdbdbd);
static const Color lineTextGrey = Color(0xff9E9E9E);


  Widget getBody(BuildContext context) {
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
                        image: AssetImage("assets/images/eukarya_logo.jpg"), fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vidrios Eukarya",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Miembro desde el 2021",
                    style:
                        TextStyle(fontSize: 15, color: black.withOpacity(0.7)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF9DBE76), borderRadius: BorderRadius.circular(5)),
                    child: GestureDetector(
                      //onTap: () => Navigator.pushNamed(context, 'donate_material'),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text("Donar Materia Prima",
                            style: TextStyle(fontSize: 18, color: white),
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
        
        ProfileMenu(
            text: "Ventas",
            icon: "assets/icons/shop.svg",
            press: () => {},
          ),
        
        ProfileMenu(
            text: "Mis Productos",
            icon: "assets/icons/gift.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Registrar Producto",
            icon: "assets/icons/check.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Kits",
            icon: "assets/icons/check.svg",
            press: () {
              Navigator.pushNamed(context, '');
            },
          ),
          ProfileMenu(
            text: "Oferta de Materia Prima",
            icon: "assets/icons/check.svg",
            press: () {
              Navigator.pushNamed(context, '');
            },
          ),


      Body(),],
    );
  }
}
*/