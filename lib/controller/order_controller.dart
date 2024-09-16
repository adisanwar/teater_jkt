import 'package:get/get.dart';
import 'package:teater_jkt/model/order_model.dart';
import 'package:teater_jkt/services/order_service.dart';
import '../model/contact_model.dart';
import '../services/ticket-service.dart';

class OrderController extends GetxController {
  final OrderService orderService = Get.put(OrderService());
  final TicketService ticketService = Get.put(TicketService());

  var isLoading = false.obs;
  var orders = <Order>[].obs;  // Change Data to Order
  var order = Order().obs;
  var contact = Contact().obs;

  // get ticketService => null;  // Change Data to Order

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  Future<Order?> fetchOrders() async {
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

  Future<Order?> getOrderById(int id) async {
    isLoading(true);
    try {
      final result = await orderService.getOrderById(id);
      if (result != null) {
        order.value = result;  // Use .value to update the observable Order
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

  Future<Order?> createOrder(Order order) async {
    isLoading(true);
    try {
      final createdOrder = await orderService.createOrder(order);
      if (createdOrder != null) {
        orders.add(createdOrder); // Tambahkan order yang baru ke list orders

        // Akses orderId dan paymentUrl dari order yang baru dibuat
        final String? orderId = createdOrder.orderId;
        final String? paymentUrl = createdOrder.paymentUrl;

        // print('Order ID: $orderId');
        // print('Payment URL: $paymentUrl');

        return createdOrder; // Return the created order
      } else {
        Get.snackbar('Error', 'Failed to create order');
        return null; // Return null if creation failed
      }
    } catch (e) {
      print("Error creating order: $e");
      Get.snackbar('Error', 'Failed to create order');
      return null; // Return null on error
    } finally {
      isLoading(false);
    }
  }




  // Future<void> createOrderAfterTicket(Ticket ticket) async {
  //   isLoading(true);
  //   try {
  //     // Step 1: Create Ticket
  //     final createdTicket = await ticketService.createTicket(ticket);
  //     if (createdTicket != null && createdTicket.id != null) {
  //       // Step 2: Use the Ticket ID to create an Order
  //       final order = Order(
  //         ticketId: createdTicket.id, // Use the created ticket's ID
  //         amount: ticket.amount, // Assuming amount is part of the ticket
  //         status: 'pending', // Default order status
  //         paymentUrl: null, // Payment URL can be set later
  //       );
  //
  //       final createdOrder = await orderService.createOrder(order);
  //       if (createdOrder != null) {
  //         fetchOrders(); // Refresh orders list
  //         Get.snackbar('Success', 'Order Created Successfully');
  //       } else {
  //         Get.snackbar('Error', 'Failed to create order');
  //       }
  //     } else {
  //       Get.snackbar('Error', 'Failed to create ticket');
  //     }
  //   } catch (e) {
  //     print("Error creating ticket and order: $e");
  //     Get.snackbar('Error', 'Failed to create ticket and order');
  //   } finally {
  //     isLoading(false);
  //   }
  // }


  Future<void> updateOrder(int id, Order order) async {
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
