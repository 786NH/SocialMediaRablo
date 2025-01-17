import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/api/api_services.dart';
import '/app_data.dart';
import '/screens/post_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final ApiService _apiService = ApiService();

  HomeScreen({Key? key}) : super(key: key);

  Future<void> _fetchPosts() async {
    try {
      final posts = await _apiService.fetchPosts();
      AppData.instance.setPosts(posts);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: FutureBuilder(
        future: _fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final posts = AppData.instance.getPosts;
          if (posts == null || posts.isEmpty) {
            return const Center(child: Text('No posts available.'));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                onTap: () => Get.to(() => PostDetailsScreen(post: post)),
              );
            },
          );
        },
      ),
    );
  }
}
