/*

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecoshops/services/categories_services.dart';
import 'package:flutter_ecoshops/widgets/product_image.dart';
import 'package:provider/provider.dart';

import 'package:flutter_ecoshops/services/products_service.dart';
import 'package:flutter_ecoshops/providers/product_form_provider.dart';

class ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(
        productService: productService,
      ),
    );
  }
}

class _ProductScreenBody extends StatefulWidget {
  final productService;

  _ProductScreenBody({Key? key, required this.productService})
      : super(key: key);

  @override
  __ProductScreenBodyState createState() => __ProductScreenBodyState();
}

class __ProductScreenBodyState extends State<_ProductScreenBody> {
  String? _selected = '';

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final categoryService = Provider.of<CategoriesService>(context);
    final product = productForm.product;
    setState(() {
      _selected = categoryService.id2Cat[product.categoryProd];
    });

    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: widget.productService.selectedProduct.image),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back_ios_new,
                          size: 40, color: Colors.white),
                    )),
                /*
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        final picker = new ImagePicker();
                        final PickedFile? pickedFile = await picker.getImage(
                            // source: ImageSource.gallery,
                            source: ImageSource.camera,
                            imageQuality: 100);

                        if (pickedFile == null) {
                          print('No seleccionó nada');
                          return;
                        }

                        productService
                            .updateSelectedProductImage(pickedFile.path);
                      },
                      icon: Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.white),
                    ))
                */
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: _buildBoxDecoration(),
                child: Form(
                  key: productForm.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      TextFormField(
                        initialValue: product.nameProd,
                        onChanged: (value) => product.nameProd = value,
                        validator: (value) {
                          if (value == null || value.length < 1)
                            return 'El nombre es obligatorio';
                        },
                        decoration: InputDecoration(
                            hintText: 'Nombre del producto',
                            labelText: 'Nombre:'),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        initialValue: product.descp,
                        onChanged: (value) => product.descp = value,
                        decoration: InputDecoration(
                            hintText: 'Descripción del producto',
                            labelText: 'Descripción:'),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        initialValue: '${product.price}',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          if (int.tryParse(value) == null) {
                            product.price = 0;
                          } else {
                            product.price = int.parse(value);
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: '\$150', labelText: 'Precio:'),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        initialValue: '${product.stock}',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          if (int.tryParse(value) == null) {
                            product.stock = 0;
                          } else {
                            product.stock = int.parse(value);
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: '10', labelText: 'Inventario:'),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: <Widget>[
                          Icon(Icons.list),
                          SizedBox(width: 30.0),
                          Expanded(
                            child: DropdownButton<String>(
                              value: _selected,
                              items: getOpcionesDropdown(categoryService),
                              onChanged: (value) {
                                setState(() {
                                  _selected = value;
                                  product.categoryProd =
                                      categoryService.cat2Id[value];
                                });
                              },
                              hint: Text('Seleccione categoría...'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: widget.productService.isSaving
            ? CircularProgressIndicator(color: Colors.white)
            : Icon(Icons.save_outlined),
        onPressed: widget.productService.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;

                //final String? imageUrl = await productService.uploadImage();

                //if (imageUrl != null) productForm.product.picture = imageUrl;

                await widget.productService
                    .saveOrCreateProduct(productForm.product);
              },
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(
      CategoriesService categoryService) {
    List<DropdownMenuItem<String>> lista = [];

    categoryService.id2Cat.values.forEach((cat) {
      lista.add(DropdownMenuItem(
        child: Text(cat),
        value: cat,
      ));
    });

    return lista;
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}


class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct.image),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back_ios_new,
                          size: 40, color: Colors.white),
                    )),
                /*
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        final picker = new ImagePicker();
                        final PickedFile? pickedFile = await picker.getImage(
                            // source: ImageSource.gallery,
                            source: ImageSource.camera,
                            imageQuality: 100);

                        if (pickedFile == null) {
                          print('No seleccionó nada');
                          return;
                        }

                        productService
                            .updateSelectedProductImage(pickedFile.path);
                      },
                      icon: Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.white),
                    ))
                */
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving
            ? CircularProgressIndicator(color: Colors.white)
            : Icon(Icons.save_outlined),
        onPressed: productService.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;

                //final String? imageUrl = await productService.uploadImage();

                //if (imageUrl != null) productForm.product.picture = imageUrl;

                await productService.saveOrCreateProduct(productForm.product);
              },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final categoryService = Provider.of<CategoriesService>(context);
    final product = productForm.product;
    String _selected = categoryService.id2Cat[product.categoryProd];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.nameProd,
                onChanged: (value) => product.nameProd = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecoration(
                    hintText: 'Nombre del producto', labelText: 'Nombre:'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: product.descp,
                onChanged: (value) => product.descp = value,
                decoration: InputDecoration(
                    hintText: 'Descripción del producto',
                    labelText: 'Descripción:'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(hintText: '\$150', labelText: 'Precio:'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.stock}',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.stock = 0;
                  } else {
                    product.stock = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(hintText: '10', labelText: 'Inventario:'),
              ),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  Icon(Icons.select_all),
                  SizedBox(width: 30.0),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selected,
                      items: getOpcionesDropdown(categoryService),
                      onChanged: (value) {
                        _selected = value;
                        product.categoryProd = categoryService.cat2Id[value];
                        print(product.categoryProd);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown(
      CategoriesService categoryService) {
    List<DropdownMenuItem<String>> lista = [];

    categoryService.id2Cat.values.forEach((cat) {
      lista.add(DropdownMenuItem(
        child: Text(cat),
        value: cat,
      ));
    });

    return lista;
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
*/