import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/api/api_services.dart';
import '/models/user_model.dart';
import '/app_data.dart';

class UserProfileScreen extends StatelessWidget {
  final int userId;
  final ApiService _apiService = ApiService();

  UserProfileScreen({required this.userId, Key? key}) : super(key: key);

  Future<void> _fetchUsers() async {
    try {
      final users = await _apiService.fetchUsers();
      AppData.instance.setUsers(users);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: FutureBuilder(
        future: _fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final users = AppData.instance.getUsers;
          final user = users?.firstWhere((u) => u.id == userId, orElse: () => UserModel(id: 0, name: 'Unknown', username: 'N/A', email: 'N/A', phone: 'N/A', website: 'N/A'));

          if (user == null || user.id == 0) {
            return const Center(child: Text('User not found.'));
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
        },
      ),
    );
  }
}
