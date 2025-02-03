import 'package:social/api/api_services.dart';
import 'package:get/get.dart';
import 'package:social/models/user_model.dart';

class UserProfileScreenController extends GetxController{
  final int userId;
  Rx<UserModel?> user = Rx<UserModel?>(null);

  UserProfileScreenController({required this.userId});
  
  @override
  void onInit() {
    super.onInit();
    _fetchUsers(userId);
    
  }
  Future<void> _fetchUsers(int userId) async {
    try {
      ApiService controller = ApiService();
      List<UserModel>fetchedUsers = await controller.fetchUsers();
      UserModel fetchedUser = fetchedUsers.firstWhere(
        (u) => u.id == userId,
        orElse: () => UserModel(
          id: 0,
          name: 'Unknown',
          username: 'N/A',
          email: 'N/A',
          phone: 'N/A',
          website: 'N/A',
        ),
      );
      user.value = fetchedUser;  
      
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}