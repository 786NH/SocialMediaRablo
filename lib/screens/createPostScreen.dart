import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/api/api_services.dart';
import 'package:social/controller/create_post_controller.dart';
import 'dart:core';
import 'package:social/models/post_model.dart';

class CreatePostScreen extends StatelessWidget {
  final ApiService apiController=ApiService();
  CreatePostController createPostController = Get.put(CreatePostController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  int getCurrentTimeInSeconds() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Obx(
             () => ElevatedButton(
              onPressed: createPostController.isLoading.value ? null : () async{
                PostModel post = PostModel(
                  id: 002+getCurrentTimeInSeconds(),
                  userId: 2+getCurrentTimeInSeconds(), 
                  title: titleController.text,
                  body: bodyController.text,
                );
                await createPostController.createPost(post);
              },
              child: createPostController.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Text('Create Post'),
            )),
          ],
        ),
      ),
    );
  }
}
