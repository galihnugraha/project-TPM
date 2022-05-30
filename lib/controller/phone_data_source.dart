import '../service/base_network.dart';

class PhoneDataSource {
  static PhoneDataSource instance = PhoneDataSource();

  // loadCountries() mengembalikan nilai dari class BaseNetwork dengan method get()
  // diisi dengan parameter “countries” dikarenakan kita ingin mengambil list dari
  // negara-negara.
  Future<Map<String, dynamic>> loadPhones(String text) {
    return BaseNetwork.get(text);
  }

  Future<Map<String, dynamic>> loadPhones2(String text) {
    return BaseNetwork.get2(text);
  }
}
