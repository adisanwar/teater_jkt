import 'package:get/get.dart';
import 'package:teater_jkt/model/ticket_model.dart';
import 'package:teater_jkt/services/ticket-service.dart';

class TicketController extends GetxController {
  final TicketService ticketService = Get.put(TicketService());

  var isLoading = false.obs;
  var tickets = <Data>[].obs;
  var ticket = Data().obs;

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

  Future<void> createTicket(Data ticket) async {
    isLoading(true);
    try {
      final success = await ticketService.createTicket(ticket);
      if (success) {
        fetchTickets();
        Get.snackbar('Success', 'Ticket Created Successfully');
      } else {
        Get.snackbar('Error', 'Failed to create ticket');
      }
    } catch (e) {
      print("Error creating ticket: $e");
      Get.snackbar('Error', 'Failed to create ticket');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateTicket(int id, Data ticket) async {
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
