import 'package:get/get.dart';
import 'package:teater_jkt/model/order_model.dart';
import 'package:teater_jkt/services/order_service.dart';

class OrderController extends GetxController {
  final OrderService orderService = Get.put(OrderService());

  var isLoading = false.obs;
  var orders = <Data>[].obs;
  var order = Data().obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    isLoading(true);
    try {
      final result = await orderService.getOrders();
      if (result != null) {
        orders.assignAll(result);
      } else {
        Get.snackbar('Error', 'Failed to fetch orders');
      }
    } catch (e) {
      print("Error fetching orders: $e");
      Get.snackbar('Error', 'Failed to fetch orders');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getOrderById(int id) async {
    isLoading(true);
    try {
      final result = await orderService.getOrderById(id);
      if (result != null) {
        order(result);
      } else {
        Get.snackbar('Error', 'Failed to fetch order');
      }
    } catch (e) {
      print("Error fetching order: $e");
      Get.snackbar('Error', 'Failed to fetch order');
    } finally {
      isLoading(false);
    }
  }

  Future<void> createOrder(Data order) async {
    isLoading(true);
    try {
      final success = await orderService.createOrder(order);
      if (success) {
        fetchOrders();
        Get.snackbar('Success', 'Order Created Successfully');
      } else {
        Get.snackbar('Error', 'Failed to create order');
      }
    } catch (e) {
      print("Error creating order: $e");
      Get.snackbar('Error', 'Failed to create order');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateOrder(int id, Data order) async {
    isLoading(true);
    try {
      final success = await orderService.updateOrder(id, order);
      if (success) {
        fetchOrders();
        Get.snackbar('Success', 'Order Updated Successfully');
      } else {
        Get.snackbar('Error', 'Failed to update order');
      }
    } catch (e) {
      print("Error updating order: $e");
      Get.snackbar('Error', 'Failed to update order');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteOrder(int id) async {
    isLoading(true);
    try {
      final success = await orderService.deleteOrder(id);
      if (success) {
        fetchOrders();
        Get.snackbar('Success', 'Order Deleted Successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete order');
      }
    } catch (e) {
      print("Error deleting order: $e");
      Get.snackbar('Error', 'Failed to delete order');
    } finally {
      isLoading(false);
    }
  }
}
