import 'package:ezycourse/presentation/viewmodels/feed_viewmodel.dart';
import 'package:ezycourse/presentation/widgets/common_widgets.dart';
import 'package:ezycourse/presentation/widgets/primary_button.dart';
import 'package:ezycourse/utils/color_constants.dart';
import 'package:ezycourse/utils/string_constants.dart';
import 'package:ezycourse/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/entities/feed.dart';
import '../../../infrastructure/datasources/local/database.dart';

class LogoutScreen extends ConsumerStatefulWidget {
  const LogoutScreen({super.key});

  @override
  ConsumerState createState() => _LogoutState();
}

class _LogoutState extends ConsumerState<LogoutScreen>{

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConfig.backgroundColorPrimary,
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var provider = ref.watch(feedViewModelProvider);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                provider.isLoadingLogout ? getLoader() : const Icon(Icons.logout, size: 55, color: ColorConfig.primaryColor),

                const SizedBox(height: 20),
                Text(StringConfig.areuSuretoLogout, style: textSize18w600),

                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: PrimaryButton(
                    btnColor: ColorConfig.primaryColor.withOpacity(0.85),
                    btnText: StringConfig.logout,
                    onPressed: () async {
                      provider.logout();
                      // DatabaseHelper dbHelper = DatabaseHelper();
                      // List<Feed> feeds = await dbHelper.getFeeds();
                      // for (var feed in feeds) {
                      //   print(feed.feedTxt);
                      // }
                    },
                  ),
                ),

              ],
            );
          }
        ),
      ),
    );
  }
}
