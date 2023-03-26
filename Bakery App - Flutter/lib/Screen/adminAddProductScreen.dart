import 'dart:io';

import 'package:bakey/model/product_model.dart';
import 'package:bakey/repository/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import '../app/userPermission.dart';

class AdminAddProductScreen extends StatefulWidget {
  const AdminAddProductScreen({super.key});

  static const String route = "adminAddProductScreen";

  @override
  State<AdminAddProductScreen> createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  @override
  void initState() {
    _checkUserPermission();
    super.initState();
  }

  _checkUserPermission() async {
    await UserPermission.checkCameraPermission();
  }

  final _key = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: 'Vanilla Cake');
  final _priceController = TextEditingController(text: '200');
  final _weightController = TextEditingController(text: '2 kg');
  final _descriptionController =
      TextEditingController(text: 'Babbbal xa you cake try garnus');

  _saveProduct() async {
    Product product = Product(
      name: _nameController.text,
      price: double.parse(_priceController.text),
      weight: _weightController.text,
      description: _descriptionController.text,
    );
    int status = await ProductRepositoryImpl().addProduct(_img, product);
    _showMessage(status);
  }

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

  _showMessage(int status) {
    if (status > 0) {
      MotionToast.success(
        description: const Text("Added successfully"),
      ).show(context);
      // Navigator.pushNamed(context, LoginScreen.route);
    } else {
      MotionToast.error(
        description: const Text("Product Addition Failed"),
      ).show(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Your Next Product",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _selectImage();
                    },
                    child: SizedBox(
                      height: 200,
                      width: double.infinity - 500,
                      child: CircleAvatar(
                        radius: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: _img == null
                              ? const Text("Tap to Add Product Image here")
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
                  const Text(
                    "Produt Name",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans Italic",
                    ),
                  ),
                  TextFormField(
                    controller: _nameController,
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
                  const Text(
                    "Produt Price",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans Italic",
                    ),
                  ),
                  TextFormField(
                    controller: _priceController,
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
                  const Text(
                    "Produt Weight",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans Italic",
                    ),
                  ),
                  TextFormField(
                    controller: _weightController,
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
                  const Text(
                    "Post Description",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans Italic",
                    ),
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
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
                  SizedBox(
                    key: const Key('btnProduct'),
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _saveProduct();
                        }
                      },
                      child: const Text(
                        'Add Product',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Brand Bold",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
