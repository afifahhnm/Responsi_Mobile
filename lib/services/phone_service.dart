import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/phone_model.dart';

class PhoneService {
  static const String _baseUrl = "https://tpm-api-responsi-e-f-872136705893.us-central1.run.app/api/v1/phones";


  static Future<List<Data>> getAllPhone() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['data'] is List) {
        final List phoneJson = jsonData['data'];
        return phoneJson.map((e) => Data.fromJson(e)).toList();
      } else {
        throw Exception('Format data smartphone tidak dikenali');
      }
    } else {
      throw Exception('Gagal mengambil smartphone dengan status ${response.statusCode}');
    }
  }


  static Future<Data> getPhoneById(int id) async {
    final response = await http.get(Uri.parse("$_baseUrl/$id"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final phoneResponse = ClassName.fromJson(jsonData);
      if (phoneResponse.data != null) {
        return phoneResponse.data!;
      } else {
        throw Exception('Data smartphone kosong');
      }
    } else {
      throw Exception('Gagal mengambil smartphone dengan status ${response.statusCode}');
    }
  }

 
  static Future<ClassName> createPhone(Data phone) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'model': phone.model,
        'brand': phone.brand,
        'ram': phone.ram,
        'price': phone.price,
        'storage': phone.storage,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return ClassName.fromJson(jsonData);
    } else {
      throw Exception('Gagal membuat smartphone: ${response.body}');
    }
  }

  
  static Future<ClassName> updatePhone(Data phone) async {
    if (phone.id == null) {
      throw Exception("Id phone tidak boleh null");
    }

    final response = await http.put(
      Uri.parse("$_baseUrl/${phone.id}"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'model': phone.model,
        'brand': phone.brand,
        'ram': phone.ram,
        'price': phone.price,
        'storage': phone.storage,
      }),
    );

    print("Update status code: ${response.statusCode}");
    print("Update response body: ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ClassName.fromJson(jsonData);
    } else {
      throw Exception('Gagal update smartphone: ${response.body}');
    }
  }


  static Future<void> deletePhone(int id) async {
    final response = await http.delete(Uri.parse("$_baseUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception('Gagal hapus smartphone dengan status ${response.statusCode}');
    }
  }
}
