import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:validate_form/UI/input_decoration.dart';
import 'package:validate_form/providers/product_form_provider.dart';
import 'package:validate_form/services/services.dart';
import 'package:validate_form/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsServices = Provider.of<ProductsServices>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productsServices.selectedProduct),
      child: _ProductScreenBody(productsServices: productsServices),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productsServices,
  }) : super(key: key);

  final ProductsServices productsServices;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productsServices.selectedProduct.picture,
                ),
                Positioned(
                  top: 30,
                  left: 20,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      )),
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: IconButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? pickedFile =
                          await picker.pickImage(source: ImageSource.camera);

                      if (pickedFile == null) {
                        print('No selecciono nada ');
                        return;
                      }
                      print('Tenemos imagen ${pickedFile.path}');
                      productsServices
                          .updateSelectedProductImage(pickedFile.path);
                    },
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const _ProductForm(),
            const SizedBox(height: 200)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () async {
          if (!productForm.isValidate()) return;

          await productsServices.saveOrCreateProduct(productForm.product);

          Navigator.pop(context);
        },
        child: const Icon(
          Icons.save_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50),
        width: double.infinity,
        decoration: _productFormDecoration(),
        child: Form(
          key: productForm.formkey,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                maxLines: 1,
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length <= 1) {
                    return "El nombre es obligatorio";
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'ex: test@test.com',
                  labelText: 'Product name',
                  labelTextColor: Colors.green,
                  prefixIconColor: Colors.deepPurple,
                  prefixIcon: Icons.keyboard_alt_outlined,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                initialValue: product.price.toString(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'ex: test@test.com',
                  labelText: 'Price',
                  labelTextColor: Colors.green,
                  prefixIconColor: Colors.deepPurple,
                  prefixIcon: Icons.attach_money,
                ),
              ),
              const SizedBox(height: 40),
              SwitchListTile.adaptive(
                activeColor: Colors.indigo,
                title: const Text('Avaliable'),
                tileColor: Colors.green,
                value: product.avaliable,
                onChanged: (value) => productForm.updateAvailability(value),
              )
            ],
          ),
        ));
  }

  BoxDecoration _productFormDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 4), blurRadius: 20)
          ]);
}
