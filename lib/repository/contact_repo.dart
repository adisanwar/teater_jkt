// import 'package:get/get.dart';
// import 'package:teater_jkt/api/urls.dart';
// import 'package:teater_jkt/model/contact_model.dart';
// import 'package:teater_jkt/services/api_services.dart';

// class ContactRepository {
//   final apiService = Get.find<ApiService>();

//   Future<List<ContactModel>> getAllContacts() async {
//     try {
//       final response = await apiService.get('${Url.baseUrl}/contacts');
//       if (response.statusCode == 200) {
//         return (response.body as List).map((contact) => ContactModel.fromJson(contact)).toList();
//       } else {
//         throw Exception('Failed to load contacts');
//       }
//     } catch (e) {
//       print("Error fetching contacts: $e");
//       rethrow;
//     }
//   }

//   Future<ContactModel> getContactById(int id) async {
//     try {
//       final response = await apiService.get('${Url.baseUrl}/contacts/$id');
//       if (response.statusCode == 200) {
//         return ContactModel.fromJson(response.body);
//       } else {
//         throw Exception('Failed to load contact');
//       }
//     } catch (e) {
//       print("Error fetching contact: $e");
//       rethrow;
//     }
//   }

//   Future<bool> createContact(ContactModel contact) async {
//     try {
//       final response = await apiService.post('${Url.baseUrl}/contacts', contact.toJson());
//       return response.statusCode == 201;
//     } catch (e) {
//       print("Error creating contact: $e");
//       return false;
//     }
//   }

//   Future<bool> updateContact(int id, ContactModel contact) async {
//     try {
//       final response = await apiService.put('${Url.baseUrl}/contacts/$id', contact.toJson());
//       return response.statusCode == 200;
//     } catch (e) {
//       print("Error updating contact: $e");
//       return false;
//     }
//   }

//   Future<bool> deleteContact(int id) async {
//     try {
//       final response = await apiService.delete('${Url.baseUrl}/contacts/$id');
//       return response.statusCode == 200;
//     } catch (e) {
//       print("Error deleting contact: $e");
//       return false;
//     }
//   }
// }
