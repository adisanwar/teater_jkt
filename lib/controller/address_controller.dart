import 'package:get/get.dart';
import 'package:teater_jkt/model/address_model.dart';
import 'package:teater_jkt/services/address_service.dart';

class AddressController extends GetxController {
  final AddressService addressService = Get.put(AddressService());

  var isLoading = false.obs;
  var addresses = <Address>[].obs;
  var address = Address().obs;

  // Mendapatkan daftar semua address untuk kontak tertentu
  Future<void> getAddressList(int contactId) async {
    isLoading(true);
    try {
      final result = await addressService.getAddressList(contactId);
      addresses(result);
    } catch (e) {
      print("Error fetching address list: $e");
      Get.snackbar('Error', 'Failed to fetch address list');
    } finally {
      isLoading(false);
    }
  }

  // Mendapatkan detail address tertentu
  Future<void> getAddress(int contactId, int addressId) async {
    isLoading(true);
    try {
      final result = await addressService.getAddress(contactId, addressId);
      if (result != null) {
        address(result);
      } else {
        Get.snackbar('Error', 'Failed to fetch address');
      }
    } catch (e) {
      print("Error fetching address: $e");
      Get.snackbar('Error', 'Failed to fetch address');
    } finally {
      isLoading(false);
    }
  }

  // Membuat address baru
  Future<void> createAddress(int contactId, Address address) async {
    isLoading(true);
    try {
      final success = await addressService.createAddress(contactId, address);
      if (success) {
        getAddressList(contactId); // Refresh list
        Get.snackbar('Success', 'Address Created Successfully');
      } else {
        Get.snackbar('Error', 'Failed to create address');
      }
    } catch (e) {
      print("Error creating address: $e");
      Get.snackbar('Error', 'Failed to create address');
    } finally {
      isLoading(false);
    }
  }

  // Memperbarui address tertentu
  Future<void> updateAddress(int contactId, int addressId, Address address) async {
    isLoading(true);
    try {
      final success = await addressService.updateAddress(contactId, addressId, address);
      if (success) {
        getAddressList(contactId); // Refresh list
        Get.snackbar('Success', 'Address Updated Successfully');
      } else {
        Get.snackbar('Error', 'Failed to update address');
      }
    } catch (e) {
      print("Error updating address: $e");
      Get.snackbar('Error', 'Failed to update address');
    } finally {
      isLoading(false);
    }
  }

  // Menghapus address tertentu
  Future<void> deleteAddress(int contactId, int addressId) async {
    isLoading(true);
    try {
      final success = await addressService.deleteAddress(contactId, addressId);
      if (success) {
        getAddressList(contactId); // Refresh list
        Get.snackbar('Success', 'Address Deleted Successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete address');
      }
    } catch (e) {
      print("Error deleting address: $e");
      Get.snackbar('Error', 'Failed to delete address');
    } finally {
      isLoading(false);
    }
  }
}
