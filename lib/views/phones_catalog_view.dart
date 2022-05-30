import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:galsphone/views/phone_desc_view.dart';
import 'package:hive/hive.dart';
import 'package:galsphone/controller/phone_data_source.dart';
import 'package:galsphone/models/phone.dart';
import 'package:galsphone/models/shop.dart';

import '../boxes.dart';
import 'cart_view.dart';

class PhonesCatalog extends StatefulWidget {
  final String text;

  const PhonesCatalog({Key? key, required this.text}) : super(key: key);

  @override
  _PhonesCatalogState createState() => _PhonesCatalogState();
}

class _PhonesCatalogState extends State<PhonesCatalog> {
  late String phoneName;
  late String brand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phones Catalog"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartView(),
                  ));
            },
          ),
        ],
      ),
      body: Container(
        // FutureBuilder() membentuk hasil Future dari request API kita
        child: FutureBuilder(
          future: PhoneDataSource.instance.loadPhones(widget.text),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              Phone phone = Phone.fromJson(snapshot.data);
              return _buildSuccessSection(phone);
            }
            return _buildLoadingSection();
          },
        ),
      ),
    );
  }

  // Jika API sedang dipanggil
  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  // Jika data ada
  Widget _buildSuccessSection(Phone data) {
    return ListView.builder(
      itemCount: data.data!.phones?.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image(
            image: NetworkImage(
                data.data!.phones![index].image!),
          ),
          title: Text("${data.data!.phones![index].phone_name}"),
          subtitle: Text(
              "${data.data!.phones![index].brand}",
              style: TextStyle(fontSize: 11.0),
            ),
          isThreeLine: true,
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return PhoneDesc(text: data.data!.phones![index].detail!);
              })),
          trailing: ElevatedButton.icon(
            onPressed: () {
              phoneName = "${data.data!.phones![index].phone_name}";
              brand = "${data.data!.phones![index].brand}";
              _onFormSubmit();
            },
            icon: const Icon(
              // <-- Icon
              Icons.add,
              size: 16.0,
            ),
            label: Text('Add to Bookmarks'), // <-- Text
          ),
        );
      },
    );
  }

  void _onFormSubmit() {
    Box<Shop> shopBox = Hive.box<Shop>(HiveBoxes.shop);
    shopBox.add(Shop(phoneName: phoneName, brand: brand));
    print(shopBox);
  }
}
