import 'dart:io';
import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:ezycourse/presentation/widgets/common_widgets.dart';
import 'package:ezycourse/utils/color_constants.dart';
import 'package:ezycourse/utils/size_config.dart';
import 'package:ezycourse/utils/string_constants.dart';
import 'package:ezycourse/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/asset_constants.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState createState() => _CreatePostScreen();
}

class _CreatePostScreen extends ConsumerState<CreatePostScreen> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (context, WidgetRef ref, Widget? child) {
        var provider = ref.watch(feedViewModelProvider);

        return Scaffold(
          backgroundColor: ColorConfig.backgroundColorPrimary,
          appBar: AppBar(
            backgroundColor: ColorConfig.backgroundColorPrimary,
            title: const Text('Create Post'),
            actions: [
              provider.isLoadingCreateFeed
                  ?
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: getLoader(),
              )
                  :
              TextButton(
                onPressed: () async {
                  if (provider.postController.text.isNotEmpty) {
                    await ref.watch(feedViewModelProvider.notifier).createNewFeed();
                    provider.notify();
                  } else {
                    Get.snackbar("Error!", "Please write something to post.",
                        backgroundColor: ColorConfig.redColor.withOpacity(0.20), colorText: ColorConfig.textColorPrimary,
                    );
                  }
                },
                child: Text(StringConfig.createPost, style: textSize14w600),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(AssetConfig.user_icon_rounded),
                      ),

                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'User Name', // Replace with actual user name
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: ColorConfig.greyColor.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.public, size: 16),
                                const SizedBox(width: 4),
                                Text(StringConfig.privacy),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Card(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: provider.selectedGradientBg,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: provider.isLoadingCreateFeed
                          ?
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: getProportionateScreenHeight(150),
                          maxHeight: getProportionateScreenHeight(250),
                        ),
                        child: getLoader(color: ColorConfig.whiteColor),
                      )
                          :
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: getProportionateScreenHeight(150),
                          maxHeight: getProportionateScreenHeight(250),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            controller: provider.postController,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: "What's on your mind?",
                              hintStyle: TextStyle(color: ColorConfig.greyColor),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: getProportionateScreenHeight(10),),
                  Row(
                    children: [
                      Flexible(flex: 0,
                        child: InkWell(
                            onTap: () {
                              provider.isBgVisible = !provider.isBgVisible;
                              provider.notify();
                            },
                            child: Card(
                              color: provider.isBgVisible ? ColorConfig.primaryColorLite : ColorConfig.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    provider.isBgVisible ? Icons.keyboard_arrow_left_rounded : Icons.keyboard_arrow_right_rounded,
                                    size: 40,
                                    color: provider.isBgVisible ? ColorConfig.whiteColor : ColorConfig.primaryColorLite,
                                  ),
                                ))),
                      ),

                      Flexible(flex: 0,
                        child: InkWell(
                            onTap: () {
                              provider.isBgVisible = false;
                              provider.selectedBgGradientIndex = -1;
                              provider.selectedGradientBg = const LinearGradient(colors: [ColorConfig.whiteColor, ColorConfig.whiteColor]);
                              provider.notify();
                            },
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: getProportionateScreenHeight(50),
                                  width: getProportionateScreenWidth(50),
                                  margin: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: const Icon(Icons.not_interested_rounded,
                                    size: 45,
                                    color: ColorConfig.greyColor,
                                  ),
                                ),
                                const Text("No Color", style: textSize10,),
                              ],
                            )),
                      ),

                      if (!provider.isBgVisible) const SizedBox() else Flexible(
                        child: SizedBox(
                          height: getProportionateScreenHeight(90),
                          width: SizeConfig.screenWidth,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: GradientColorList.gradientsColor.length,
                            itemBuilder: (context, index) {

                              return InkWell(
                                onTap: () {
                                  provider.selectedBgGradientIndex = index;
                                  provider.selectedGradientBg = GradientColorList.gradientsColor[index];
                                  provider.getSelectedGradientJsonForBgColor(provider.selectedGradientBg);
                                  provider.notify();
                                },
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: getProportionateScreenHeight(35),
                                      width: getProportionateScreenWidth(35),
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        gradient: GradientColorList.gradientsColor[index],
                                        borderRadius: BorderRadius.circular(8),
                                        border: provider.selectedBgGradientIndex == index ? Border.all(color: ColorConfig.whiteColor, width: 4) : null,
                                        boxShadow: provider.selectedBgGradientIndex == index
                                            ? [
                                          BoxShadow(
                                            color: ColorConfig.blueColor.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 8,
                                          ),
                                        ] : [],
                                      ),
                                    ),

                                    Text("Color ${index + 1}", style: textSize10,),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}