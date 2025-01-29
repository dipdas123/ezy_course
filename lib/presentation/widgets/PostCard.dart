import 'package:ezycourse/core/entities/feed.dart';
import 'package:ezycourse/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';

class PostCardWidget extends StatelessWidget {
  final Feed? feed;
  const PostCardWidget({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(feed?.user?.profilePic ?? ""),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(feed?.user?.fullName ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(DateTime.parse(feed?.publishDate ?? "").timeAgo ?? "", style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            feed?.fileType == "text" ? Text(feed?.feedTxt ?? "") : Image.network(feed?.user?.profilePic ?? ""),
            const SizedBox(height: 10),
            // Engagement Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.thumb_up),
                      onPressed: () {
                        // Handle like
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        // Handle comment
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        // Handle share
                      },
                    ),
                  ],
                ),
                const Text('100 likes', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}