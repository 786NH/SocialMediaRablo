import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/controller/home_screen_controller.dart';
import 'package:social/screens/createPostScreen.dart';
import '/screens/post_details_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController homeScreenController = Get.put(HomeScreenController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts') , backgroundColor: Colors.blue,),
      body: Obx(() {
        if (homeScreenController.posts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: homeScreenController.posts.length,
          itemBuilder: (context, index) {
            final post = homeScreenController.posts[index];
            return Card(
              child: ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
              onTap: () => Get.to(() => PostDetailsScreen(post: post)),
            ),
            );
             
          },
        );
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
     Get.to(CreatePostScreen());
      },child: Icon(Icons.create),
      ),
    );
  }
}
























// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:social/controller/home_screen_controller.dart';
// import '/api/api_services.dart';
// import '/app_data.dart';
// import '/screens/post_details_screen.dart';

// class HomeScreen extends StatelessWidget {
//   final ApiService _apiService = ApiService();

//   HomeScreen({Key? key}) : super(key: key);
  
//   HomeScreenController homeScreenController =Get.put(HomeScreenController());


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Posts')),
//       body: Obx(()=>
//         FutureBuilder(
//         future: homeScreenController._fetchPosts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           final posts = AppData.instance.getPosts;
//           if (posts == null || posts.isEmpty) {
//             return const Center(child: Text('No posts available.'));
//           }

//           return ListView.builder(
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               return ListTile(
//                 title: Text(post.title),
//                 subtitle: Text(post.body),
//                 onTap: () => Get.to(() => PostDetailsScreen(post: post)),
//               );
//             },
//           );
//         },
//       ),
//     )
      
//     );
//   }
// }
