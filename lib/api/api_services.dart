import 'package:dio/dio.dart';
import '/models/post_model.dart';
import '/models/comment_model.dart';
import '/models/user_model.dart';
import '../exceptions/app_exceptions.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<PostModel>> fetchPosts() async {
    print("4");
    try {
      print("5");
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      print("5");
      return (response.data as List).map((json) => PostModel.fromJson(json)).toList();
    } on DioError catch (e) {
      print("DioError: ${e.response?.statusCode ?? 'Unknown'} - ${e.message}");
      throw AppExceptions('Failed to fetch posts: ${e.message}');}
    catch (e) {
      print("6");
      throw AppExceptions('Failed to fetch posts');
    }
  }

  Future<List<CommentModel>> fetchComments(int postId) async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/comments', queryParameters: {'postId': postId});
      return (response.data as List).map((json) => CommentModel.fromJson(json)).toList();
    } catch (e) {
      throw AppExceptions('Failed to fetch comments');
    }
  }

  Future<List<UserModel>> fetchUsers() async {
    
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users');
      return (response.data as List).map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      throw AppExceptions('Failed to fetch users');
    }
  }

  Future<PostModel> createPost(PostModel post) async {
    try {
     final response = await _dio.post('https://jsonplaceholder.typicode.com/posts', data: post.toJson());
       return PostModel.fromJson(response.data);
    } catch (e) {
      throw AppExceptions('Failed to create post');
    }
  }
}
