import 'package:get/get.dart';
import 'package:teater_jkt/model/show_model.dart';
import 'package:teater_jkt/services/show_service.dart';

class ShowController extends GetxController {
  final ShowService showService = Get.put(ShowService());

  var isLoading = false.obs;
  var shows = <Data>[].obs;
  var show = Data().obs;

  @override
  void onInit() {
    fetchShows();
    super.onInit();
  }

  Future<void> fetchShows() async {
    isLoading(true);
    try {
      final result = await showService.getShows();
      print(result);
      if (result != null) {
        shows.assignAll(result);

      } else {
        Get.snackbar('Error', 'Failed to fetch shows');
      }
    } catch (e) {
      print("Error fetching shows: $e");
      Get.snackbar('Error', 'Failed to fetch shows');
    } finally {
      isLoading(false);
    }
  }


  Future<void> getShowById(int id) async {
    isLoading(true);
    try {
      final result = await showService.getShowById(id);
      if (result != null) {
        show(result);
      } else {
        Get.snackbar('Error', 'Failed to fetch show');
      }
    } catch (e) {
      print("Error fetching show: $e");
      Get.snackbar('Error', 'Failed to fetch show');
    } finally {
      isLoading(false);
    }
  }

  Future<void> createShow(Data show) async {
    isLoading(true);
    try {
      final success = await showService.createShow(show);
      if (success) {
        fetchShows();
        Get.snackbar('Success', 'Show Created Successfully');
      } else {
        Get.snackbar('Error', 'Failed to create show');
      }
    } catch (e) {
      print("Error creating show: $e");
      Get.snackbar('Error', 'Failed to create show');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateShow(int id, Data show) async {
    isLoading(true);
    try {
      final success = await showService.updateShow(id, show);
      if (success) {
        fetchShows();
        Get.snackbar('Success', 'Show Updated Successfully');
      } else {
        Get.snackbar('Error', 'Failed to update show');
      }
    } catch (e) {
      print("Error updating show: $e");
      Get.snackbar('Error', 'Failed to update show');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteShow(int id) async {
    isLoading(true);
    try {
      final success = await showService.deleteShow(id);
      if (success) {
        fetchShows();
        Get.snackbar('Success', 'Show Deleted Successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete show');
      }
    } catch (e) {
      print("Error deleting show: $e");
      Get.snackbar('Error', 'Failed to delete show');
    } finally {
      isLoading(false);
    }
  }
}
