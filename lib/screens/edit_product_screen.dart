import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: "",
    title: "",
    price: 0,
    description: "",
    imageURL: "",
  );
  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageURL": "",
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productID = ModalRoute.of(context)!.settings.arguments as String?;
      if (productID != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findByID(productID);
        _initValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
        };
        _imageUrlController.text = _editedProduct.imageURL;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('png') &&
              !_imageUrlController.text.endsWith('jpeg') &&
              !_imageUrlController.text.endsWith('jpg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    var isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
    setState(() => _isLoading = true);
    log(
      "ID: ${_editedProduct.id}\n"
      "Title: ${_editedProduct.title}\n"
      "Description: ${_editedProduct.description}\n"
      "Price: ${_editedProduct.price.toString()}\n"
      "ImageURL: ${_editedProduct.imageURL}",
    );
    if (_editedProduct.id.isNotEmpty) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (e) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("An Error Occured!"),
            content: const Text("Something went wrong."),
            actions: [
              ElevatedButton(
                child: const Text("Go Back"),
                onPressed: () => Navigator.pop(ctx),
              ),
            ],
          ),
        );
      }
    }
    setState(() => _isLoading = false);
    if (!mounted) return;
    Navigator.pop(context);
  }

  // void _saveForm() {
  //   var isValid = _form.currentState!.validate();
  //   if (isValid) {
  //     _form.currentState!.save();
  //     setState(() => _isLoading = true);
  //     log(
  //       "ID: ${_editedProduct.id}\n"
  //       "Title: ${_editedProduct.title}\n"
  //       "Description: ${_editedProduct.description}\n"
  //       "Price: ${_editedProduct.price.toString()}\n"
  //       "ImageURL: ${_editedProduct.imageURL}",
  //     );
  //     if (_editedProduct.id.isNotEmpty) {
  //       Provider.of<Products>(context, listen: false)
  //           .updateProduct(_editedProduct.id, _editedProduct);
  //       setState(() => _isLoading = false);
  //       Navigator.pop(context);
  //     } else {
  //       Provider.of<Products>(context, listen: false)
  //           .addProduct(_editedProduct)
  //           .catchError(
  //             // ignore: prefer_void_to_null
  //             (e) => showDialog<Null>(
  //               context: context,
  //               builder: (ctx) => AlertDialog(
  //                 title: const Text("An Error Occured!"),
  //                 content: const Text("Something went wrong."),
  //                 actions: [
  //                   ElevatedButton(
  //                     child: const Text("Go Back"),
  //                     onPressed: () => Navigator.pop(ctx),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )
  //           .then((_) {
  //         setState(() => _isLoading = false);
  //         Navigator.pop(context);
  //       });
  //     }
  //   }
  //   // Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Product',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _form,
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  TextFormField(
                    initialValue: _initValues["title"],
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      prefixIcon: Icon(Icons.title),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_priceFocusNode),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Title!';
                      }
                      return null;
                    },
                    onSaved: (value) => _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: value!,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageURL: _editedProduct.imageURL,
                    ),
                  ),
                  TextFormField(
                    initialValue: _initValues["price"],
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      prefixIcon: Icon(Icons.currency_rupee),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid Price';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Please enter a Price greater than 0';
                      }
                      return null;
                    },
                    onSaved: (value) => _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value!),
                      imageURL: _editedProduct.imageURL,
                    ),
                  ),
                  TextFormField(
                    initialValue: _initValues["description"],
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 3,
                    focusNode: _descriptionFocusNode,
                    keyboardType: TextInputType.multiline,
                    onFieldSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(_descriptionFocusNode),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Description';
                      }
                      if (value.length < 15) {
                        return 'Description should be at lease 15 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) => _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: _editedProduct.title,
                      description: value!,
                      price: _editedProduct.price,
                      imageURL: _editedProduct.imageURL,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Image URL',
                      prefixIcon: Icon(Icons.image),
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onFieldSubmitted: (_) => _saveForm(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an Image URL.';
                      }
                      if (!value.startsWith('http') &&
                              !value.startsWith('https') ||
                          !value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                        return 'Please enter a valid Image URL.';
                      }
                      return null;
                    },
                    onSaved: (value) => _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageURL: value!,
                    ),
                  ),
                  Container(
                    height: 300,
                    margin: const EdgeInsets.only(top: 40, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Center(
                            child: Text(
                              'Image Preview',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.fill,
                          ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveForm,
        child: const Icon(Icons.save),
      ),
    );
  }
}
