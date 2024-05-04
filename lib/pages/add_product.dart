import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:footware_admin/pages/homepage.dart';
import 'package:footware_admin/upload_image.dart';
import 'package:footware_admin/widgets/custom_dropbtn.dart';
import 'package:footware_admin/widgets/textformfield.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/home_controller.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    super.key,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // File? _image;
  // final picker = ImagePicker();
  //
  // Future getImage() async {
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedImage != null) {
  //     setState(() {
  //       _image = File(pickedImage.path);
  //     });
  //   }
  // }
  StorageService storage =StorageService();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 254, 169, 169),
          title: const Text("Add product"),
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.all(10),
          width: double.maxFinite,
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Add New Product",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.indigoAccent,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(
                  thickness: 1.8,
                  color: Color.fromARGB(66, 27, 27, 27),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  controller: ctrl.nameController,
                  hintText: "Product Name",
                  length: 1,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  controller: ctrl.desController,
                  hintText: "Product Description",
                  length: 3,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter your description';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  controller: ctrl.priceController,
                  hintText: "Product price",
                  length: 1,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter a price';
                    }
                    RegExp regex = RegExp(r'^\d+(\.\d+)?$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  controller: ctrl.imgController,
                  hintText: "Image url",
                  length: 1,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: CustomDropButton(
                        items: const [
                          'category',
                          'Heal',
                          "Boots",
                          'Sneakers',
                          'leather'
                        ],
                        selectedValue: 'category',
                        onSelected: (selectedValue) {
                          ctrl.category = selectedValue ?? 'general';
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Flexible(
                        child: CustomDropButton(
                      items: const ['brand', 'addidas', 'puma', 'nike'],
                      selectedValue: 'brand',
                      onSelected: (selectedValue) {
                        ctrl.brand = selectedValue ?? "addidas";
                      },
                    ))
                  ],
                ),
                const Text("Other Product"),
                CustomDropButton(
                  items: const ['Offer', 'false', 'true'],
                  selectedValue: 'Offer',
                  onSelected: (selectedValue) {
                    ctrl.offer =
                        bool.tryParse(selectedValue ?? 'false') ?? false;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(onPressed: () async {
                  ImagePicker _picker = ImagePicker();
                  final XFile? _image = await  _picker.pickImage(source: ImageSource.gallery);
                  if(_image != null ){
                    await storage.uploadImage(_image);
                    var imageUrl= await storage.downloadUrl(_image.name);
                    ctrl.update();
                  }
                },
                    icon: Icon(Icons.add_a_photo)),
                ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      ctrl.addProduct();
                      Navigator.pop(context);
                      ctrl.fetchProducts();
                    }
                  },
                  child: Text("Add product"),
                ),
              ],
            ),
          ),
        )),
      );
    });
  }
}
