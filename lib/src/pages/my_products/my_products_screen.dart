import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_ecoshops/constants.dart';
import 'package:flutter_ecoshops/src/pages/my_products/components/body.dart';
import 'package:flutter_ecoshops/components/coustom_bottom_nav_bar.dart';
import 'package:flutter_ecoshops/enums.dart';

class MyProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.products),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[SizedBox(width: kDefaultPaddin / 2)],
    );
  }
}
