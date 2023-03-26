import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import '../app/constant.dart';
import '../model/product_model.dart';
import '../repository/product_repo.dart';

class ProductUpdateScreen extends StatefulWidget {
  const ProductUpdateScreen({super.key});

  static const String route = "productUpdateScreen";

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  late Product product;

  @override
  void didChangeDependencies() {
    product = ModalRoute.of(context)!.settings.arguments as Product;
    super.didChangeDependencies();
  }

  final _key = GlobalKey<FormState>();
  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      // Source is either Gallary or Camera
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _selectImage() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[300],
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _browseImage(ImageSource.camera);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _browseImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              icon: const Icon(Icons.image),
              label: const Text('Gallery'),
            )
          ],
        ),
      ),
    );
  }

  // final _nameController = TextEditingController();
  // final _priceController = TextEditingController();
  // final _weightController = TextEditingController();
  // final _descriptionController = TextEditingController();

  final _nameController = TextEditingController(text: 'sdfsdf Cake');
  final _priceController = TextEditingController(text: '2200');
  final _weightController = TextEditingController(text: '5 kg');
  final _descriptionController =
      TextEditingController(text: 'Babbbal xa you casdfasdfke try garnus');

  _updateProduct(String productId) async {
    Product product = Product(
      name: _nameController.text,
      price: double.parse(_priceController.text),
      weight: _weightController.text,
      description: _descriptionController.text,
    );
    int status =
        await ProductRepositoryImpl().updateProduct(_img, product, productId);
    _showMessage(status);
  }

  _showMessage(int status) {
    if (status > 0) {
      MotionToast.success(
        description: const Text("Product Updated successfully"),
      ).show(context);
      // Navigator.pushNamed(context, LoginScreen.route);
    } else {
      MotionToast.error(
        description: const Text("Product Update Failed"),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Product"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _key,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity - 500,
                    child: CircleAvatar(
                      radius: 50,
                      child: InkWell(
                        onTap: () {
                          _selectImage();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _img == null
                              ? Image.network(
                                  Constant.productImageURL + product.image!,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                )
                              // ? Image.asset("assets/images/bakery.jpg")
                              : Image.file(
                                  _img!,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Produt Name: ${product.name}",
                    // product.productID!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans Italic",
                    ),
                  ),
                  TextFormField(
                    controller: _nameController,
                    // initialValue: product.name!,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product name';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Produt Price: ${product.price!.toString()}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans Italic",
                    ),
                  ),
                  TextFormField(
                    controller: _priceController,
                    // initialValue: product.price!.toString(),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product price';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Produt Weight: ${product.weight!}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans Italic",
                    ),
                  ),
                  TextFormField(
                    controller: _weightController,
                    // initialValue: product.weight!,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product weight';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Post Description \n${product.description!}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans Italic",
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    // initialValue: product.description!,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _updateProduct(product.productID!);
        },
        label: const Text('Update Product'),
        icon: const Icon(Icons.update),
        backgroundColor: const Color.fromARGB(255, 218, 166, 10),
      ),
    );
  }
}
