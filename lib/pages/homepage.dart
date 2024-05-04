import 'package:flutter/material.dart';
import 'package:footware_admin/controller/home_controller.dart';
import 'package:footware_admin/pages/add_product.dart';
import 'package:footware_admin/pages/orderList.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 224, 226),
      appBar: AppBar(
        title: const Text(
          "Footware admin",
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          IconButton(onPressed: (){
            ctrl.order;
            Get.to(() => OrderList());
          }, icon: Icon(Icons.shower))
        ],
      ),
      body: ListView.builder(
        itemCount: ctrl.products.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){},
            child: Card(
              child: ListTile(
                title:  Text(ctrl.products[index].name?? ''),
                subtitle:  Text((ctrl.products[index].price ?? 0).toString()),
                trailing:
                    IconButton(onPressed: () {
                      ctrl.deleteProduct(ctrl.products[index].id ?? '');
                    }, icon: const Icon(Icons.delete)),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ctrl.fetchOrder();
          Get.to(AddProduct());
        },
        child: const Icon(Icons.add),
      ),
    );
  });
  }
}