import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ezycourse/core/entities/CreateFeedBody.dart';
import 'package:ezycourse/core/entities/create_feed.dart';
import 'package:ezycourse/core/entities/create_update_reaction_body.dart';
import 'package:ezycourse/infrastructure/datasources/remote/api_endpoints.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../core/entities/Reply.dart';
import '../../core/entities/comment.dart';
import '../../core/entities/comment_reply_create_response.dart';
import '../../core/entities/create_comment_or_reply_body.dart';
import '../../core/entities/create_update_reaction.dart';
import '../../core/entities/feed.dart';
import '../../core/repositories/post_repository.dart';
import '../datasources/remote/api_client.dart';

class FeedRepositoryImpl implements FeedRepository {
  final ApiClient apiClient;
  FeedRepositoryImpl(this.apiClient);

  @override
  Future<List<Feed?>> getFeed(int? lastItemId) async {
    try {
      final response = await apiClient.postRequest(
        endpoint: getFeeds,
        data: {
          'community_id': "2914",
          'space_id': "5883",
          'more': lastItemId,
        },
        query: {
          "status" : "feed"
        },
      );

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List).map((item) => Feed.fromJson(item)).toList();
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

  @override
  Future<List<Comment>> getCommentOfAFeed(int? feedID) async {
    try {
      final response = await apiClient.getRequest(
        endpoint: "$getCommentsOfAFeed$feedID",
        query: {
          "more" : ""
        },
      );

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List).map((item) => Comment.fromJson(item)).toList();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');

        if (e.response?.data is Map<String, dynamic>) {
          final errorMap = e.response?.data as Map<String, dynamic>;
          throw Exception(errorMap.toString());
        }
      }
      print('Comment error: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return [];
  }

  @override
  Future<List<Reply>> getCommentReplyOfAFeed(int? commentID) async {
    try {
      final response = await apiClient.getRequest(
        endpoint: "$getCommentsReplyOfAFeed$commentID",
        query: {
          "more" : ""
        },
      );

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List).map((item) => Reply.fromJson(item)).toList();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');

        if (e.response?.data is Map<String, dynamic>) {
          final errorMap = e.response?.data as Map<String, dynamic>;
          throw Exception(errorMap.toString());
        }
      }
      print('Reply error: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return [];
  }

  @override
  Future<CreatePost> createPost(CreateFeedBody body) async {
    try {
      var bodyData = jsonEncode(body.toJson());
      printInfo(info: "selectedGradientJson toJsoned body :: $bodyData");

          final response = await apiClient.postRequest(
        endpoint: createFeed,
        data: body.toJson(),
        query: {},
      );

      if (response.statusCode == 200) {
        return CreatePost.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');

        if (e.response?.data is Map<String, dynamic>) {
          final errorMap = e.response?.data as Map<String, dynamic>;
          throw Exception(errorMap.toString());
        }
      }
      print('Reply error: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return CreatePost();
  }

  @override
  Future<CreateUpdateReaction> createOrUpdateReaction(CreateUpdateReactionBody body) async {
    try {
      final response = await apiClient.postRequest(
        endpoint: updateOrCreateReaction,
        data: body.toJson(),
        query: {},
      );

      if (response.statusCode == 200) {
        // return (response.data as List).map((items)=> CreateUpdateReaction.fromJson(items)).toList();
        return CreateUpdateReaction.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');

        if (e.response?.data is Map<String, dynamic>) {
          final errorMap = e.response?.data as Map<String, dynamic>;
          throw Exception(errorMap.toString());
        }
      }
      print('CreateUpdateReaction error: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return CreateUpdateReaction();
  }

  @override
  Future<CreateCommentOrReplyResponse> createComment(CreateCommentOrReplyBody body) async {
    try {
      final response = await apiClient.postRequest(
        endpoint: createCommentUrl,
        data: body.toJson(),
        query: {},
      );

      if (response.statusCode == 200) {
        // return (response.data as List).map((items)=> CreateUpdateReaction.fromJson(items)).toList();
        return CreateCommentOrReplyResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');

        if (e.response?.data is Map<String, dynamic>) {
          final errorMap = e.response?.data as Map<String, dynamic>;
          throw Exception(errorMap.toString());
        }
      }
      print('CreateUpdateReaction error: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return CreateCommentOrReplyResponse();
  }

  @override
  Future<CreateCommentOrReplyResponse> replyComment(CreateCommentOrReplyBody body) async {
    try {
      final response = await apiClient.postRequest(
        endpoint: replyCommentUrl,
        data: body.toJson(),
        query: {},
      );

      if (response.statusCode == 200) {
        // return (response.data as List).map((items)=> CreateUpdateReaction.fromJson(items)).toList();
        return CreateCommentOrReplyResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');

        if (e.response?.data is Map<String, dynamic>) {
          final errorMap = e.response?.data as Map<String, dynamic>;
          throw Exception(errorMap.toString());
        }
      }
      print('CreateUpdateReaction error: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return CreateCommentOrReplyResponse();
  }

  @override
  Future<dynamic> logout() async {
    try {
      final response = await apiClient.postRequest(
        endpoint: logoutUrl,
        query: {},
      );

      if (response.statusCode == 200) {
        // return (response.data as List).map((items)=> CreateUpdateReaction.fromJson(items)).toList();
        return response.data;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error response: ${e.response?.data}');

        if (e.response?.data is Map<String, dynamic>) {
          final errorMap = e.response?.data as Map<String, dynamic>;
          throw Exception(errorMap.toString());
        }
      }
      print('logout error: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return null;
  }

}