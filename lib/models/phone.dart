// To parse this JSON data, do
//
//     final phone = phoneFromJson(jsonString);

import 'dart:convert';
import '../service/base_network.dart';

Phone phoneFromJson(String str) => Phone.fromJson(json.decode(str));

class Phone {
  bool? status;
  Data? data;

  Phone({
    required this.status,
    required this.data,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String? title;
  List<Phones>? phones;

  Data({
    required this.title,
    required this.phones,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        phones: List<Phones>.from(json["phones"].map((x) => Phones.fromJson(x))),
      );
}

class Phones {
  String? brand;
  String? phone_name;
  String? slug;
  String? image;
  String? detail;

  Phones({
    required this.brand,
    required this.phone_name,
    required this.slug,
    required this.image,
    required this.detail,
  });

  factory Phones.fromJson(Map<String, dynamic> json) => Phones(
        brand:  json['brand'],
        phone_name: json["phone_name"],
        slug: json["slug"],
        image: json["image"],
        detail: json["detail"],
      );
}
