import 'package:flutter/material.dart';

import 'package:flutter_ecoshops/src/pages/screens.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomeScreen(),
    'products': (BuildContext context) => ProductsScreen(),
    //'product_form': (BuildContext context) => ProductForm(),
    'login': (BuildContext context) => LoginScreen(),
    'forgot_password': (BuildContext context) => ForgotPassword(),
    'create_account': (BuildContext context) => CreateAccount(),
    'profile': (BuildContext context) => ProfileScreen(),
    'details': (BuildContext context) => DetailsScreen(),
    'cart': (BuildContext context) => CartScreen(),
    'register_entrepreneurship': (BuildContext context) =>
        RegisterEntrepreneurship(),
    'my_entrepreneurship': (BuildContext context) => EntrepreneurPage(),
    'entrepreneurships': (BuildContext context) => EntrepreneurshipsPage(),
    'update_user': (BuildContext context) => UpdateUser(),
    'donate_material': (BuildContext context) => DonateMaterial(),
    'kits': (BuildContext context) => KitScreen(),
    'my_products': (BuildContext context) => MyProducts(),
    'orders': (BuildContext context) => OrdersScreen(),
    'sales': (BuildContext context) => SalesScreen(),
    'oferta': (BuildContext context) => OfertaMateriaScreen(),
    'register_product': (BuildContext context) => RegisterProductPage(),
  };
}
