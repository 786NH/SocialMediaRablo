
import 'package:get/get.dart';

import 'package:social/api/api_services.dart';
import 'package:social/models/post_model.dart';


class CreatePostController extends GetxController{
   RxBool isLoading = false.obs;
  
  Future<void> createPost(PostModel post) async {
    try {
      isLoading.value=true;
      ApiService controller = ApiService();
      PostModel createdPost = await controller.createPost(post);
      Get.snackbar('Success', 'Post Created with ID: ${createdPost.id}\n Post title: ${createdPost.title}');
      
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }finally {
      isLoading.value = false;
    }
  }

}