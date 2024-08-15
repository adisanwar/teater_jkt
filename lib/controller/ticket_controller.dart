import 'package:get/get.dart';
import 'package:teater_jkt/model/order_model.dart';
import 'package:teater_jkt/model/ticket_model.dart';
import 'package:teater_jkt/services/ticket-service.dart';

class TicketController extends GetxController {
  final TicketService ticketService = Get.put(TicketService());

  var isLoading = false.obs;
  var tickets = <Ticket>[].obs;
  var ticket = Ticket().obs;

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
        ticket.value = result; // Use .value to assign the Ticket object
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

  Future<Ticket?> createTicket(ticket) async {
    isLoading(true);
    try {
      // Data statis untuk membuat tiket
      // final ticket = Ticket(
      //   seatNumber: 'A12',
      //   photo: 'https://example.com/photos/seat_a12.png',
      //   // purchaseDate: '2024-08-14',
      //   contactId: 1,
      //   showId: 2,
      // );

      final Ticket? Tickets = await ticketService.createTicket(ticket);
      if (Tickets != null) {
        fetchTickets();
        // Get.snackbar('Success', 'Ticket Created Successfully');
        return Tickets;
      } else {
        Get.snackbar('Error', 'Failed to create ticket');
        return null;
      }
    } catch (e) {
      print("Error creating ticket: $e");
      print(ticket);
      Get.snackbar('Error', 'Failed to create ticket');
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateTicket(int id, Ticket ticket) async {
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
