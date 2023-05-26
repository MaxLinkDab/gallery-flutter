import 'package:dio/dio.dart';
import '../const.dart';
import '../domain/entity/post.dart';
import '../domain/entity/user.dart';

class Repository {
  final Dio _dio = Dio();
  final String _urlPhoto = baseUrl + photosUrl;

  Future<List<Post>> getPosts(
      {required String trend, required int page, required limit}) async {
    var response = await _dio.get(_urlPhoto,
        queryParameters: {trend: true, 'page': page, 'limit': limit});
    return (response.data['data'] as List).map((e) => Post.fromMap(e)).toList();
  }

  Future<User> getUserInfo(int id) async {
    var response = await _dio.get(baseUrl + userUrl + id.toString());
    return User.fromMap(response.data);
  }

  Future<List<User>> getAllUser() async {
    try {
      var response = await _dio
          .get(baseUrl + userUrl, queryParameters: {'limit': 1000000});
      return (response.data['data'] as List)
          .map((e) => User.fromMap(e))
          .toList();
    } on DioError catch (e) {
      return [];
    }
  }
}
