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
import '../../../utils/app_logs.dart';
import '../../../utils/color_constants.dart';
import '../../../utils/internet_connectivity.dart';
import '../../widgets/post_card_widget.dart';
import '../../widgets/common_widgets.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      InternetConnectivity().checkInternetConnection((bool isConnected) {
        if (!mounted) return;
        AppLogs.infoLog("isConnectedFeed :: $isConnected");
        final provider = ref.read(feedViewModelProvider.notifier);
        provider.isInternetConnected = isConnected;

        if (isConnected) {
          provider.getFeed();
        } else {
          provider.getOfflineFeed();
        }
      });
    });
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
                provider.isInternetConnected
                    ?
                Container(
                  height: getProportionateScreenHeight(35),
                  width: getProportionateScreenWidth(65),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: ColorConfig.greenColor.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    splashColor: ColorConfig.primaryColor,
                    onTap: () {
                      provider.isInternetConnected = true;
                      provider.notify();
                      ref.read(feedViewModelProvider.notifier).getFeed();
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Online", style: textSize12w600.copyWith(color: ColorConfig.whiteColor),),
                        const Icon(Icons.refresh_rounded, color: ColorConfig.whiteColor, size: 20,),
                      ],
                    ),
                  ),
                )
                    :
                Container(
                  height: getProportionateScreenHeight(35),
                  width: getProportionateScreenWidth(65),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: ColorConfig.whiteColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  InkWell(
                    splashColor: ColorConfig.primaryColor,
                    onTap: () {
                      provider.isInternetConnected = false;
                      provider.notify();
                      ref.read(feedViewModelProvider.notifier).getOfflineFeed();
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Offline", style: textSize12w600.copyWith(color: ColorConfig.whiteColor),),
                        const Icon(Icons.do_not_disturb_alt_rounded, color: ColorConfig.whiteColor, size: 20,),
                      ],
                    ),
                  ),
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
                if (provider.isInternetConnected) {
                  ref.read(feedViewModelProvider.notifier).getFeed();
                } else {
                  ref.read(feedViewModelProvider.notifier).getOfflineFeed();
                }
                provider.notify();
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
                                backgroundImage: AssetImage(AssetConfig.user2),
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