import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/home_controller.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async{ ctrl.fetchOrder(); },
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 209, 224, 226),
          appBar: AppBar(
            title: const Text(
              "Orders",
              style: TextStyle(fontSize: 17),
            ),
          ),
          body: ListView.builder(
            itemCount:ctrl.order.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title:Text(ctrl.order[index].item?? ''),
                  subtitle:Text((ctrl.order[index].price ?? 0).toString()),

                ),
              );
            },
          ),
        ),
      );
    });
  }
}
