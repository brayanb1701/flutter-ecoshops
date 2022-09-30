import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  /*
  updateAvailability( bool value ) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }
  */

  bool isValidForm() {
    /*
    print( product.name );
    print( product.price );
    print( product.available );
    */
    print("Validacion realizada");

    return formKey.currentState?.validate() ?? false;
  }
}
