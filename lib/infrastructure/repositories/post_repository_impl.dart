import 'package:dio/dio.dart';
import 'package:ezycourse/infrastructure/datasources/remote/api_endpoints.dart';
import '../../core/entities/feed.dart';
import '../../core/repositories/post_repository.dart';
import '../datasources/remote/api_client.dart';

class FeedRepositoryImpl implements FeedRepository {
  final ApiClient apiClient;
  FeedRepositoryImpl(this.apiClient);

  @override
  Future<List<Feed?>> getFeed() async {
    try {
      final response = await apiClient.postRequest(
        endpoint: getFeeds,
        data: {
          'community_id': "2914",
          'space_id': "5883",
          'more': '',
        },
        query: {
          "status" : "feed"
        },
      );

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((item) => Feed.fromJson(item))
            .toList();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');

        if (e.response?.data is Map<String, dynamic>) {
          final errorMap = e.response?.data as Map<String, dynamic>;
          throw Exception(errorMap.toString());
        }
      }
      print('Login error: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return [];
  }
}