import 'package:flutter/material.dart';
import 'package:validate_form/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Product product;

//! Es importante que este producto sea una copia de el producto y no el producto en si
  ProductFormProvider(this.product);

  updateAvailability(bool value) {
    print(value);
    product.avaliable = value;
    notifyListeners();
  }

  bool isValidate() {
    print(product.name);
    print(product.price);
    print(product.avaliable);

    return formkey.currentState?.validate() ?? false;
  }
}
