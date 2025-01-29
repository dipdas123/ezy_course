import 'package:ezycourse/presentation/screens/feed/create_post_Screen.dart';
import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:ezycourse/presentation/widgets/primary_button.dart';
import 'package:ezycourse/utils/asset_constants.dart';
import 'package:ezycourse/utils/string_constants.dart';
import 'package:ezycourse/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../utils/color_constants.dart';
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
    ref.read(feedViewModelProvider.notifier).getFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      var provider = ref.watch(feedViewModelProvider);

        return Scaffold(
          backgroundColor: ColorConfig.backgroundColorPrimary,
          appBar: AppBar(
            backgroundColor: ColorConfig.primaryColor,
            title: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringConfig.communityFeed, style: textSize18w600.copyWith(color: ColorConfig.whiteColor),),
                Text(StringConfig.post, style: textSize12w500.copyWith(color: ColorConfig.whiteColor),),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(provider.isLoading ? Icons.download_for_offline_rounded : Icons.restart_alt, color: ColorConfig.whiteColor,),
                onPressed: () {
                  ref.read(feedViewModelProvider.notifier).getFeed();
                },
              ),
            ],
          ),
          body: provider.isLoading
              ?
          Center(
            child: Container(
              height: getProportionateScreenHeight(25),
              alignment: Alignment.center,
              child: SizedBox(
                height: getProportionateScreenHeight(25),
                width: getProportionateScreenWidth(25),
                child: const CircularProgressIndicator(
                  strokeWidth: 6.0,
                  valueColor: AlwaysStoppedAnimation<Color>(ColorConfig.primaryColorLite),
                ),
              ),
            ),
          )
              :
          Column(
            children: [

              InkWell(
                onTap: () {
                  Get.to(()=> const CreatePostScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 2,
                    color: ColorConfig.whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(AssetConfig.user_icon_square),
                          ),

                          const SizedBox(width: 10),
                          Expanded(
                            child: Text("Write something here...", style: textSize14w500.copyWith(color: ColorConfig.greyColor),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const Expanded(child: PostCardWidget()),

            ],
          ),
        );
      }
    );
  }
}