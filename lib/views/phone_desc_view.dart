import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:galsphone/views/phone_desc_view.dart';
import 'package:hive/hive.dart';
import 'package:galsphone/controller/phone_data_source.dart';
import 'package:galsphone/models/phone.dart';
import 'package:galsphone/models/phone_desc.dart';

import '../boxes.dart';
import 'cart_view.dart';

class PhoneDesc extends StatelessWidget {
  final String text;

  const PhoneDesc({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar( ),
      body: Container(
        // FutureBuilder() membentuk hasil Future dari request API kita
        child: FutureBuilder(
          future: PhoneDataSource.instance.loadPhones2(text),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              DescPhone descphone = DescPhone.fromJson(snapshot.data);
              return _buildSuccessSection(descphone);
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
  
  @override
  Widget _buildSuccessSection(DescPhone descphone) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${descphone.data!.phone_name}'),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Image(
                image: NetworkImage(descphone.data!.thumbnail!),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text("by ${descphone.data!.brand}"),
              SizedBox(
                height: 10.0,
              ),
              Text("Release Date : ${descphone.data!.release_date}"),
              SizedBox(
                height: 10.0,
              ),
              Text("Dimension : ${descphone.data!.dimension}"),
              SizedBox(
                height: 10.0,
              ),
              Text("Operating System : ${descphone.data!.os}"),
              SizedBox(
                height: 10.0,
              ),
              Text("Storage : ${descphone.data!.storage}"),
            ],
          ),
        ),
      ),
    );
  }
}
