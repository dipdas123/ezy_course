import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/asset_constants.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState createState() => _CreatePostScreen();
}

class _CreatePostScreen extends ConsumerState<CreatePostScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetConfig.splashBgMain,
              fit: BoxFit.fill,
            ),
          ),

          Image.asset(
            AssetConfig.splashBgTopCircle,
            fit: BoxFit.fitWidth,
          ),

          Image.asset(
            AssetConfig.splashBgMiddleCircle,
            fit: BoxFit.contain,
          ),

          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 120,
              child: Image.asset(AssetConfig.appLogo),
            ),
          ),

        ],
      ),
    );
  }
}