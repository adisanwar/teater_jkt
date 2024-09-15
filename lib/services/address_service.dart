import 'package:get/get.dart';
import 'package:teater_jkt/api/urls.dart';
import 'package:teater_jkt/model/address_model.dart';
import 'token_service.dart';

class AddressService extends GetConnect {
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

  Future<Address?> getAddress(int contactId, int addressId) async {
    try {
      final response = await get('${Url.getContact}/$contactId/addresses/$addressId');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return Address.fromJson(response.body['data']);
      } else {
        print('Failed to fetch address: ${response.statusCode} - ${response.statusText}');
        return null;
      }
    } catch (e) {
      print("Error fetching address: $e");
      return null;
    }
  }

  Future<List<Address>> getAddressList(int contactId) async {
    try {
      final response = await get('${Url.getContact}/$contactId/addresses');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        List<Address> addresses = (response.body['data'] as List).map((item) => Address.fromJson(item)).toList();
        return addresses;
      } else {
        print('Failed to fetch address list: ${response.statusCode} - ${response.statusText}');
        return [];
      }
    } catch (e) {
      print("Error fetching address list: $e");
      return [];
    }
  }

  Future<bool> createAddress(int contactId, Address address) async {
    try {
      final response = await post('${Url.createContact}/$contactId/addresses', address.toJson());
      return response.statusCode == 201;
    } catch (e) {
      print("Error creating address: $e");
      return false;
    }
  }

  Future<bool> updateAddress(int contactId, int addressId, Address address) async {
    try {
      final response = await patch('${Url.updateContact}/$contactId/addresses/$addressId', address.toJson());
      return response.statusCode == 200;
    } catch (e) {
      print("Error updating address: $e");
      return false;
    }
  }

  Future<bool> deleteAddress(int contactId, int addressId) async {
    try {
      final response = await delete('${Url.deleteContact}/$contactId/addresses/$addressId');
      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting address: $e");
      return false;
    }
  }
}
