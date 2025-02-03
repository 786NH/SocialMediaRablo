import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/controller/user_profile_screen_controller.dart';

class UserProfileScreen extends StatelessWidget {
  final int userId;

  UserProfileScreen({required this.userId, Key? key}) : super(key: key){
    Get.put(UserProfileScreenController(userId: userId));
  }
  
  @override
  Widget build(BuildContext context) {
    final UserProfileScreenController userProfileScreenController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Obx( (){
        final user = userProfileScreenController.user.value;
          if(user==null){
           return const Center(child: CircularProgressIndicator());
       }
       

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${user.name}', style: const TextStyle(fontSize: 16)),
                Text('Username: ${user.username}', style: const TextStyle(fontSize: 16)),
                Text('Email: ${user.email}', style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
  })
          
        
      );
  
  }
}
