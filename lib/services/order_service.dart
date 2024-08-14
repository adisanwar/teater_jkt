import 'package:get/get.dart';
import 'package:teater_jkt/api/urls.dart';
import 'package:teater_jkt/model/order_model.dart';
import 'token_service.dart';

class OrderService extends GetConnect {
  final TokenService tokenService = TokenService();

  @override
  void onInit() {
    httpClient.addRequestModifier<void>((request) {
      final token = tokenService.getToken();
      if (token != null) {
        request.headers['X-API-TOKEN'] = token;
      }
      return request;
    });
    super.onInit();
  }

  Future<List<Data>?> getOrders() async {
    try {
      final response = await get(Url.getOrders);
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return (response.body['data'] as List)
            .map((order) => Data.fromJson(order))
            .toList();
      } else {
        print('Failed to fetch orders: ${response.statusCode} - ${response.statusText}');
        return null;
      }
    } catch (e) {
      print("Error fetching orders: $e");
      return null;
    }
  }

  Future<Data?> getOrderById(int id) async {
    try {
      final response = await get('${Url.baseUrl}/orders/$id');
      if (response.statusCode == 200) {
        return Data.fromJson(response.body['data']);
      } else {
        print('Failed to fetch order: ${response.statusCode} - ${response.statusText}');
        return null;
      }
    } catch (e) {
      print("Error fetching order: $e");
      return null;
    }
  }

  Future<bool> createOrder(Data order) async {
    try {
      final response = await post(Url.createOrders, order.toJson());
      return response.statusCode == 201;
    } catch (e) {
      print("Error creating order: $e");
      return false;
    }
  }

  Future<bool> updateOrder(int id, Data order) async {
    try {
      final response = await put('${Url.updateOrders}/$id', order.toJson());
      return response.statusCode == 200;
    } catch (e) {
      print("Error updating order: $e");
      return false;
    }
  }

  Future<bool> deleteOrder(int id) async {
    try {
      final response = await delete('${Url.deleteOrders}/$id');
      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting order: $e");
      return false;
    }
  }
}
