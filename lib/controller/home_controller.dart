import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footware_admin/model/order/order.dart';
import 'package:footware_admin/model/product/product.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference orderCollection;

  TextEditingController nameController = TextEditingController();

  TextEditingController desController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController imgController = TextEditingController();

  String category = "general ";
  String brand = " brand";
  bool offer = false;

  List<Product> products = [];
  List<orders> order =[];


  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    orderCollection = firestore.collection('orders');
    await fetchProducts();
    await fetchOrder();
    update();
    super.onInit();
  }

  addProduct() {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        id: doc.id,
        name: nameController.text,
        category: category,
        description: desController.text,
        price: double.tryParse(priceController.text),
        brand: brand,
        image: imgController.text,
        offer: offer,
      );

      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Done', 'product added successfully',
          colorText: Colors.green);
      setValueDefault();
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrieveProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      products.clear();
      products.assignAll(retrieveProducts);
      // Get.snackbar('Success', 'successfully added', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error!', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }

  deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
      Get.snackbar('Success', 'successfully deleted', colorText: Colors.green);
    } on Exception catch (e) {
      Get.snackbar('eroor', e.toString(), colorText: Colors.green);
    }
  }

  setValueDefault() {
    nameController.clear();
    priceController.clear();
    desController.clear();
    imgController.clear();
  }

  fetchOrder()async{
    try {
      QuerySnapshot ordersSnapshot = await orderCollection.get();
      final List<orders> retrieveorders = ordersSnapshot.docs
          .map((doc) => orders.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      order.clear();
      order.assignAll(retrieveorders);

    } on Exception catch (e) {
      Get.snackbar('Error!', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
    // Get.snackbar('Success', 'successfully added', colorText: Colors.green);
  }
}
