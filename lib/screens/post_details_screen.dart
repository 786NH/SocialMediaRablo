import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/api/api_services.dart';
import '/models/post_model.dart';
import '/app_data.dart';
import 'user_profile_screen.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostModel post;
  final ApiService _apiService = ApiService();

  PostDetailsScreen({required this.post, Key? key}) : super(key: key);

  Future<void> _fetchComments() async {
    try {
      final comments = await _apiService.fetchComments(post.id);
      AppData.instance.setComments(comments);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: FutureBuilder(
        future: _fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final comments = AppData.instance.getComments;
          if (comments == null || comments.isEmpty) {
            return const Center(child: Text('No comments available.'));
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
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
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
        },
      ),
    );
  }
}
