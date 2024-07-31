import 'package:get/get.dart';
import 'package:teater_jkt/api/urls.dart';
import 'package:teater_jkt/model/show_model.dart';
import 'token_service.dart';

class ShowService extends GetConnect {
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

  Future<List<Data>?> getShows() async {
    try {
      final response = await get(Url.getShows);
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return (response.body['data'] as List)
            .map((show) => Data.fromJson(show))
            .toList();
      } else {
        print('Failed to fetch shows: ${response.statusCode} - ${response.statusText}');
        return null;
      }
    } catch (e) {
      print("Error fetching shows: $e");
      return null;
    }
  }

  Future<Data?> getShowById(int id) async {
    try {
      final response = await get('${Url.baseUrl}/shows/$id');
      if (response.statusCode == 200) {
        return Data.fromJson(response.body['data']);
      } else {
        print('Failed to fetch show: ${response.statusCode} - ${response.statusText}');
        return null;
      }
    } catch (e) {
      print("Error fetching show: $e");
      return null;
    }
  }

  Future<bool> createShow(Data show) async {
    try {
      final response = await post(Url.createShows, show.toJson());
      return response.statusCode == 201;
    } catch (e) {
      print("Error creating show: $e");
      return false;
    }
  }

  Future<bool> updateShow(int id, Data show) async {
    try {
      final response = await put('${Url.updateShows}/$id', show.toJson());
      return response.statusCode == 200;
    } catch (e) {
      print("Error updating show: $e");
      return false;
    }
  }

  Future<bool> deleteShow(int id) async {
    try {
      final response = await delete('${Url.deleteShows}/$id');
      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting show: $e");
      return false;
    }
  }
}
