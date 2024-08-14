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

  Future<List<Data>?> getTickets() async {
    try {
      final response = await get(Url.getTickets);
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return (response.body['data'] as List)
            .map((ticket) => Data.fromJson(ticket))
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

  Future<Data?> getTicketById(int id) async {
    try {
      final response = await get('${Url.baseUrl}/tickets/$id');
      if (response.statusCode == 200) {
        return Data.fromJson(response.body['data']);
      } else {
        print('Failed to fetch ticket: ${response.statusCode} - ${response.statusText}');
        return null;
      }
    } catch (e) {
      print("Error fetching ticket: $e");
      return null;
    }
  }

  Future<bool> createTicket(Data ticket) async {
    try {
      final response = await post(Url.createTickets, ticket.toJson());
      return response.statusCode == 201;
    } catch (e) {
      print("Error creating ticket: $e");
      return false;
    }
  }

  Future<bool> updateTicket(int id, Data ticket) async {
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
