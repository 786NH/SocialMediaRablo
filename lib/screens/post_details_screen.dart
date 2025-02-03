import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/controller/post_detail_screen_controller.dart';
import '/models/post_model.dart';
import 'user_profile_screen.dart';

class PostDetailsScreen extends StatelessWidget {
  PostModel post;
  PostDetailsScreen({required this.post, Key? key}) : super(key: key) {
   Get.put(PostDetailScreenController(post: post));
  }


  @override
  Widget build(BuildContext context) {
    final PostDetailScreenController postDetailScreenController = Get.find();
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Obx(() {
        if (postDetailScreenController.comment.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.body,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: postDetailScreenController.comment.length,
                itemBuilder: (context, index) {
                  final comment = postDetailScreenController.comment[index];
                  return ListTile(
                    title: Text(comment.name),
                    subtitle: Text(comment.body),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => UserProfileScreen(userId: post.userId)),
              child: const Text('View Author Details'),
            ),
          ],
        );
      }),
    );
  }
}
