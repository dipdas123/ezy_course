import 'package:ezycourse/presentation/screens/feed/create_post_Screen.dart';
import 'package:ezycourse/presentation/screens/logout/logout_screen.dart';
import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:ezycourse/utils/asset_constants.dart';
import 'package:ezycourse/utils/size_config.dart';
import 'package:ezycourse/utils/string_constants.dart';
import 'package:ezycourse/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../utils/color_constants.dart';
import '../../widgets/FbReactionBox.dart';
import '../../widgets/post_card_widget.dart';
import '../../widgets/common_widgets.dart';

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

    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      var provider = ref.watch(feedViewModelProvider);

        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: ColorConfig.backgroundColorPrimary,
            appBar: provider.bottomNavIndex == 1 ? const PreferredSize(preferredSize: Size(0, 0), child: SizedBox()) : AppBar(
              backgroundColor: ColorConfig.primaryColor,
              title: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(StringConfig.communityFeed, style: textSize18w600.copyWith(color: ColorConfig.whiteColor),),
                  Text(StringConfig.post, style: textSize12w500.copyWith(color: ColorConfig.whiteColor),),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(provider.isLoadingFeeds ? Icons.download_for_offline_rounded : Icons.restart_alt, color: ColorConfig.whiteColor,),
                  onPressed: () {
                    provider.notify();
                    ref.read(feedViewModelProvider.notifier).getFeed();
                  },
                ),
              ],
            ),
            body: provider.bottomNavIndex == 0
                ? provider.isLoadingFeeds
                ?
            Center(
              child: getLoader(),
            )
                :
            RefreshIndicator(
              onRefresh: () async {
                provider.notify();
                ref.read(feedViewModelProvider.notifier).getFeed();
              },
              child: Column(
                children: [
          
                  InkWell(
                    onTap: () {
                      provider.isBgVisible = false;
                      provider.selectedGradientBg = const LinearGradient(colors: [ColorConfig.whiteColor, ColorConfig.whiteColor]);
                      provider.selectedBgGradientIndex = -1;
                      provider.selectedGradientJson = "";
                      provider.postController.clear();
                      Get.to(()=> const CreatePostScreen());
                      // Get.to(()=> const FbReactionBox());
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
            )
            :
            const LogoutScreen(),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: ColorConfig.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          
                  Flexible(
                    child: Material(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(12)/*, topRight: Radius.circular(12)*/),
                          color: provider.bottomNavIndex == 0 ? ColorConfig.primaryColor.withOpacity(0.85) : ColorConfig.whiteColor,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          splashColor: ColorConfig.primaryColorLite,
                          onTap: () {
                            provider.bottomNavIndex = 0;
                            provider.notify();
                          },
                          child: Image.asset(AssetConfig.community_icon,
                          height: getProportionateScreenHeight(35),
                            width: SizeConfig.screenWidth,
                            color: provider.bottomNavIndex == 0 ? ColorConfig.whiteColor : ColorConfig.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
          
                  Flexible(
                    child: Material(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(/*topLeft: Radius.circular(12),*/ topRight: Radius.circular(12)),
                          color: provider.bottomNavIndex == 1 ? ColorConfig.primaryColor.withOpacity(0.85) : ColorConfig.whiteColor,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          splashColor: ColorConfig.primaryColorLite,
                          onTap: () {
                            provider.bottomNavIndex = 1;
                            provider.notify();
                          },
                          child: Image.asset(AssetConfig.logout_icon,
                          height: getProportionateScreenHeight(35),
                            width: SizeConfig.screenWidth,
                            color: provider.bottomNavIndex == 1 ? ColorConfig.whiteColor : ColorConfig.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
          
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}