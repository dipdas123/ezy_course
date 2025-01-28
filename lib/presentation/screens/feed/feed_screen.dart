import 'package:ezycourse/presentation/widgets/primary_button.dart';
import 'package:ezycourse/utils/asset_constants.dart';
import 'package:ezycourse/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../utils/PrefUtils.dart';
import '../../../utils/app_logs.dart';
import '../../../utils/size_config.dart';
import '../../viewmodels/auth_viewmodel.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  var enablePostButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(StringConfig.communityFeed),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {

            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {

            },
          ),
        ],
      ),
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(AssetConfig.user_icon_square),
                    ),

                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onTap: () {},
                        decoration: InputDecoration(
                          hintText: StringConfig.writeSomeHere,
                          border: InputBorder.none,
                          suffix: enablePostButton == true ? SizedBox(
                            width: SizeConfig.screenWidth! / 5,
                            child: PrimaryButton(
                              btnText: StringConfig.post,
                              onPressed: () {

                              },
                            ),
                          ) : const SizedBox(),
                        ),
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              enablePostButton = false;
                            });
                          } else {
                            setState(() {
                              enablePostButton = true;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          for (int i = 0; i < 10; i++) PostCard(),

        ],
      ),
    );
  }
}

class PostCard extends StatelessWidget {
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
            const Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with user's profile image
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User  Name', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('2 hours ago', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            const Text('This is a sample post content. It can be text, images, or videos.'),
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