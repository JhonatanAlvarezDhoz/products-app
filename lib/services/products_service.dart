import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:validate_form/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsServices extends ChangeNotifier {
  final String _baseURL = 'products-flutter-59ee1-default-rtdb.firebaseio.com';

  final List<Product> products = [];
  bool isLoading = true;
  bool isSaving = true;
  File? newPictureFile;

  //* no es final por que va a cambiar entre true y false

  late Product selectedProduct;

  ProductsServices() {
    loadProducts();
  }

  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseURL, 'products.json');
    final response = await http.get(url);

    final Map<String, dynamic> productsMaps = json.decode(response.body);

    //Convertimos el Map en un listado para que sea mas dinamico
    productsMaps.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //created a new product

      await createProduct(product);
    } else {
      //update this product
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    //!para hacer un put es necesario enviar la url y el body, el cual se facilita debido a que en el modelo hay un body "tojson"
    final url = Uri.https(_baseURL, 'products/${product.id}.json');
    final response = await http.put(url, body: product.toJson());

    final decoData = response.body;
    print(decoData);

    //Actualizamos liasta de productos
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    //!

    final url = Uri.https(_baseURL, 'products.json');
    final response = await http.post(url, body: product.toJson());

    final decoData = json.decode(response.body);
    product.id = decoData['name'];

    //Actualizamos liasta de productos

    products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dx0pryfzn/image/upload?upload_preset=autwc6pa');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
