import 'package:get/get.dart';
import 'package:teater_jkt/model/contact_model.dart';
import 'package:teater_jkt/services/contact_service.dart';

class ContactController extends GetxController {
  final ContactService contactService = Get.put(ContactService());

  var isLoading = false.obs;
  var contact = ContactModel().obs;

  @override
  void onInit() {
    getContact();
    super.onInit();
  }

  Future<void> getContact() async {
    isLoading(true);
    try {
      final result = await contactService.getContact();
      if (result != null) {
        contact(result);
      } else {
        Get.snackbar('Error', 'Failed to fetch contact');
      }
    } catch (e) {
      print("Error fetching contact: $e");
      Get.snackbar('Error', 'Failed to fetch contact');
    } finally {
      isLoading(false);
    }
  }

  Future<void> createContact(ContactModel contact) async {
    isLoading(true);
    try {
      final success = await contactService.createContact(contact);
      if (success) {
        getContact();
        Get.snackbar('Success', 'Contact Created Successfully');
      } else {
        Get.snackbar('Error', 'Failed to create contact');
      }
    } catch (e) {
      print("Error creating contact: $e");
      Get.snackbar('Error', 'Failed to create contact');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateContact(int id, ContactModel contact) async {
    isLoading(true);
    try {
      final success = await contactService.updateContact(id, contact);
      if (success) {
        getContact();
        Get.snackbar('Success', 'Contact Updated Successfully');
      } else {
        Get.snackbar('Error', 'Failed to update contact');
      }
    } catch (e) {
      print("Error updating contact: $e");
      Get.snackbar('Error', 'Failed to update contact');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteContact(int id) async {
    isLoading(true);
    try {
      final success = await contactService.deleteContact(id);
      if (success) {
        getContact();
        Get.snackbar('Success', 'Contact Deleted Successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete contact');
      }
    } catch (e) {
      print("Error deleting contact: $e");
      Get.snackbar('Error', 'Failed to delete contact');
    } finally {
      isLoading(false);
    }
  }
}
