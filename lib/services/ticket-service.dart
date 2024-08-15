import 'package:get/get.dart';
import 'package:teater_jkt/api/urls.dart';
import 'package:teater_jkt/model/ticket_model.dart';
import 'token_service.dart';

class TicketService extends GetConnect {
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

  Future<List<Ticket>?> getTickets() async {
    try {
      final response = await get(Url.getTickets);
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return (response.body['data'] as List)
            .map((ticket) => Ticket.fromJson(ticket))
            .toList();
      } else {
        print('Failed to fetch tickets: ${response.statusCode} - ${response.statusText}');
        return null;
      }
    } catch (e) {
      print("Error fetching tickets: $e");
      return null;
    }
  }

  Future<Ticket?> getTicketById(int id) async {
    try {
      final response = await get('${Url.baseUrl}/tickets/$id');
      if (response.statusCode == 200) {
        return Ticket.fromJson(response.body['data']);
      } else {
        print('Failed to fetch ticket: ${response.statusCode} - ${response.statusText}');
        return null;
      }
    } catch (e) {
      print("Error fetching ticket: $e");
      return null;
    }
  }

  Future<Ticket?> createTicket(Ticket ticket) async {
    try {
      final response = await post(Url.createTickets, ticket.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Success creating ticket: $ticket');
        return Ticket.fromJson(response.body['data']);
      } else {
        print('Failed to create ticket: ${response.statusCode} - ${response.statusText } - ${response.body}');
        return null;
      }
    } catch (e) {
      if (e is Response) {
        final statusCode = e.statusCode ?? 'Unknown';
        final statusText = e.statusText ?? 'Unknown';
        final responseData = e.bodyString ?? 'No response body';

        print("Error creating ticket: $statusCode - $statusText");
        print("Response Data: $responseData");

        // You can return null or throw an exception if you want to handle it differently in the controller
        return null;
      } else {
        print("Error creating ticket: $e");
        return null;
      }
    }
  }


  Future<bool> updateTicket(int id, Ticket ticket) async {
    try {
      final response = await put('${Url.updateTickets}/$id', ticket.toJson());
      return response.statusCode == 200;
    } catch (e) {
      print("Error updating ticket: $e");
      return false;
    }
  }

  Future<bool> deleteTicket(int id) async {
    try {
      final response = await delete('${Url.deleteTickets}/$id');
      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting ticket: $e");
      return false;
    }
  }
}
