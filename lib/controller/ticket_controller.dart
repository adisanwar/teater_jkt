import 'package:get/get.dart';
import 'package:teater_jkt/model/order_model.dart';
import 'package:teater_jkt/model/ticket_model.dart';
import 'package:teater_jkt/services/ticket-service.dart';

class TicketController extends GetxController {
  final TicketService ticketService = Get.put(TicketService());

  var isLoading = false.obs;
  var tickets = <Data>[].obs;
  var ticket = Data().obs;
  final Ticket = TicketModel();

  @override
  void onInit() {
    fetchTickets();
    super.onInit();
  }

  Future<void> fetchTickets() async {
    isLoading(true);
    try {
      final result = await ticketService.getTickets();
      if (result != null) {
        tickets.assignAll(result);
      } else {
        Get.snackbar('Error', 'Failed to fetch tickets');
      }
    } catch (e) {
      print("Error fetching tickets: $e");
      Get.snackbar('Error', 'Failed to fetch tickets');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getTicketById(int id) async {
    isLoading(true);
    try {
      final result = await ticketService.getTicketById(id);
      if (result != null) {
        ticket(result);
      } else {
        Get.snackbar('Error', 'Failed to fetch ticket');
      }
    } catch (e) {
      print("Error fetching ticket: $e");
      Get.snackbar('Error', 'Failed to fetch ticket');
    } finally {
      isLoading(false);
    }
  }

   Future<TicketModel?> createStaticTicket() async {
  isLoading(true);
  try {
    // Data statis untuk membuat tiket
    final staticTicket =(
      seatNumber: 'A12',
      photo: 'https://example.com/photos/seat_a12.png',
      purchaseDate: '2024-08-14',
      contactId: 101,
      showId: 202,
    );

    final TicketModel? createdTicket = await ticketService.createTicket(staticTicket);
    if (createdTicket != null) {
      fetchTickets();
      Get.snackbar('Success', 'Static Ticket Created Successfully');
      return createdTicket;
    } else {
      Get.snackbar('Error', 'Failed to create static ticket');
      return null;
    }
  } catch (e) {
    print("Error creating static ticket: $e");
    Get.snackbar('Error', 'Failed to create static ticket');
    return null;
  } finally {
    isLoading(false);
  }
}


  Future<void> updateTicket(int id, ticket) async {
    isLoading(true);
    try {
      final success = await ticketService.updateTicket(id, ticket);
      if (success) {
        fetchTickets();
        Get.snackbar('Success', 'Ticket Updated Successfully');
      } else {
        Get.snackbar('Error', 'Failed to update ticket');
      }
    } catch (e) {
      print("Error updating ticket: $e");
      Get.snackbar('Error', 'Failed to update ticket');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteTicket(int id) async {
    isLoading(true);
    try {
      final success = await ticketService.deleteTicket(id);
      if (success) {
        fetchTickets();
        Get.snackbar('Success', 'Ticket Deleted Successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete ticket');
      }
    } catch (e) {
      print("Error deleting ticket: $e");
      Get.snackbar('Error', 'Failed to delete ticket');
    } finally {
      isLoading(false);
    }
  }
}
