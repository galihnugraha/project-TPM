// To parse this JSON data, do
//
//     final phone = phoneFromJson(jsonString);

import 'dart:convert';
import '../service/base_network.dart';

DescPhone phoneFromJson(String str) => DescPhone.fromJson(json.decode(str));

class DescPhone {
  Phones? data;

  DescPhone({
    required this.data,
  });

  factory DescPhone.fromJson(Map<String, dynamic> json) => DescPhone(
    data: Phones.fromJson(json["data"]),
  );
}

class Phones {
  String? brand;
  String? phone_name;
  String? thumbnail;
  String? release_date;
  String? dimension;
  String? os;
  String? storage;

  Phones({
    required this.brand,
    required this.phone_name,
    required this.thumbnail,
    required this.release_date,
    required this.dimension,
    required this.os,
    required this.storage,
  });

  factory Phones.fromJson(Map<String, dynamic> json) => Phones(
    brand:  json['brand'],
    phone_name: json["phone_name"],
    thumbnail: json["thumbnail"],
    release_date: json["release_date"],
    dimension: json["dimension"],
    os: json["os"],
    storage: json["storage"],
  );
}
