import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:ezycourse/presentation/widgets/primary_button.dart';
import 'package:ezycourse/utils/asset_constants.dart';
import 'package:ezycourse/utils/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/size_config.dart';
import '../../widgets/PostCard.dart';

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
    final provider = ref.watch(feedViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(StringConfig.communityFeed),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ref.read(feedViewModelProvider.notifier).getFeed();
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

          ...(provider.value ?? []).map((feed) => PostCardWidget(feed: feed)),

        ],
      ),
    );
  }
}