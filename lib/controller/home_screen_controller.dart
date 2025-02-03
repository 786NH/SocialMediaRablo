
import 'package:get/get.dart';

import 'package:social/api/api_services.dart';
import 'package:social/models/post_model.dart';


class HomeScreenController extends GetxController{
  RxList<PostModel>posts =<PostModel>[].obs;
  
  @override
  void onInit() {
    print("1");
    _fetchPosts();
    super.onInit();
  }
  Future<void> _fetchPosts() async {
    try {
      print("2");
      ApiService controller = ApiService();
      print("3");
      List<PostModel> fetchedPosts = await controller.fetchPosts();
      posts.assignAll(fetchedPosts);
      //print(posts);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}