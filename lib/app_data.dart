import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../models/user_model.dart';

class AppData {
  AppData._privateConstructor();

  static final AppData instance = AppData._privateConstructor();

  List<PostModel>? posts;
  List<CommentModel>? comments;
  List<UserModel>? users;

  void setPosts(List<PostModel> postList) => posts = postList;
  void setComments(List<CommentModel> commentList) => comments = commentList;
  void setUsers(List<UserModel> userList) => users = userList;

  List<PostModel>? get getPosts => posts;
  List<CommentModel>? get getComments => comments;
  List<UserModel>? get getUsers => users;
}
