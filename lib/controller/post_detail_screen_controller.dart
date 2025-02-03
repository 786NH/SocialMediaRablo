
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:social/api/api_services.dart';
import 'package:social/models/comment_model.dart';
import 'package:social/models/post_model.dart';


class PostDetailScreenController extends GetxController{
  RxList<CommentModel>comment =<CommentModel>[].obs;
  PostModel post ;
  PostDetailScreenController({required this.post, Key? key});


  @override
  void onInit() {
    _fetchComments(post);
    super.onInit();
  }
  
  Future<void> _fetchComments(PostModel post) async {
    try {
      ApiService controller = ApiService();
      List<CommentModel>Fetchedcomment = await controller.fetchComments(post.id);
      comment.assignAll(Fetchedcomment);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

}