import 'package:flutter/material.dart';
import 'package:galsphone/views/checkout_form_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:galsphone/boxes.dart';
import 'package:galsphone/models/shop.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late int totalPhone;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmark'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Shop>(HiveBoxes.shop).listenable(),
        builder: (context, Box<Shop> box, _) {
          totalPhone = box.values.length;
          if (box.values.isEmpty) {
            return Center(
              child: Text('Bookmark is Empty'),
            );
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Shop? res = box.getAt(index);
              return Dismissible(
                background: Container(
                  color: Colors.red,
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  res!.delete();
                },
                child: ListTile(
                  title: Text(res!.phoneName),
                  subtitle: Text(res.brand),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Checkout',
        child: Icon(Icons.restore_from_trash_rounded),
        onPressed: () => {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CheckoutForm(totalPhone: totalPhone,))),
        },
      ),
    );
  }
}
