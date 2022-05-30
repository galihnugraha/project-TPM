import 'package:hive/hive.dart';
import '../views/cart_view.dart';
part 'shop.g.dart'; // digunakan untuk generate file menggunakan build_runner

@HiveType(typeId: 0) class Shop extends HiveObject{
  @HiveField(0) String? id;
  @HiveField(1) final String phoneName;
  @HiveField(2) final String brand;

  Shop({
    required this.phoneName,
    required this.brand,
  });
}

