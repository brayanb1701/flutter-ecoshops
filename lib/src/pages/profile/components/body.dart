import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authServices = Provider.of<AuthService>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Mi cuenta",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.pushNamed(context, 'update_user');
            },
          ),
          ProfileMenu(
            text: "Compras",
            icon: "assets/icons/check.svg",
            press: () {Navigator.pushNamed(context, 'orders');},
          ),
          (authServices.currentUser.role == "e")
              ? ProfileMenu(
                  text: "Mi emprendimiento",
                  icon: "assets/icons/shop.svg",
                  press: () {
                    Navigator.pushNamed(context, 'my_entrepreneurship');
                  },
                )
              : ProfileMenu(
                  text: "Registrar Emprendimiento",
                  icon: "assets/icons/Question mark.svg",
                  press: () {
                    Navigator.pushNamed(context, 'register_entrepreneurship');
                  },
                ),
          ProfileMenu(
            text: "Cerrar Sesión",
            icon: "assets/icons/Log out.svg",
            press: () {
              authServices.signOut();
              Navigator.pushNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}
