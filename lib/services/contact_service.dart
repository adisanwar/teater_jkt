import 'package:get/get.dart';
import 'package:teater_jkt/api/urls.dart';
import 'package:teater_jkt/model/contact_model.dart';
import 'token_service.dart';

class ContactService extends GetConnect {
  final TokenService tokenService = TokenService();

  @override
  void onInit() {
    httpClient.addRequestModifier<void>((request) {
      final token = tokenService.getToken();
      if (token != null) {
        request.headers['X-API-TOKEN'] = token; // Menggunakan kunci 'X-API-TOKEN'
      }
      return request;
    });
    super.onInit();
  }

  Future<ContactModel?> getContact() async {
    try {
      final response = await get(Url.getContact);
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        // Mendapatkan kontak pertama dari daftar kontak
        return ContactModel.fromJson(response.body['data'][0]);
      } else {
        print('Failed to fetch contact: ${response.statusCode} - ${response.statusText}');
        return null;
      }
    } catch (e) {
      print("Error fetching contact: $e");
      return null;
    }
  }

  Future<bool> createContact(ContactModel contact) async {
    try {
      final response = await post(Url.createContact, contact.toJson());
      return response.statusCode == 201;
    } catch (e) {
      print("Error creating contact: $e");
      return false;
    }
  }

  Future<bool> updateContact(int id, ContactModel contact) async {
    try {
      final response = await put('${Url.updateContact}/$id', contact.toJson());
      return response.statusCode == 200;
    } catch (e) {
      print("Error updating contact: $e");
      return false;
    }
  }

  Future<bool> deleteContact(int id) async {
    try {
      final response = await delete('${Url.deleteContact}/$id');
      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting contact: $e");
      return false;
    }
  }
}
