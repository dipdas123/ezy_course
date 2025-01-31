import 'package:ezycourse/presentation/widgets/primary_button.dart';
import 'package:ezycourse/utils/color_constants.dart';
import 'package:ezycourse/utils/extensions/string_extension.dart';
import 'package:ezycourse/utils/size_config.dart';
import 'package:ezycourse/utils/string_constants.dart';
import 'package:ezycourse/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/asset_constants.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              AssetConfig.splashBgMain,
              fit: BoxFit.fill,
            ),
          ),

          Positioned(
            child: Image.asset(
              AssetConfig.splashBgTopCircle,
              fit: BoxFit.contain, // Adjust based on design
            ),
          ),

          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Image.asset(
                AssetConfig.splashBgMiddleCircle,
                fit: BoxFit.contain, // Adjust based on design
              ),
            ),
          ),

          Positioned(
            child: Container(
              height: getProportionateScreenHeight(110),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 125),
              child: Image.asset(
                AssetConfig.appLogo,
                fit: BoxFit.contain, // Adjust based on design
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: SizeConfig.screenHeight! / 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [ColorConfig.primaryColorLite, ColorConfig.primaryColor, ColorConfig.primaryColorDark],
                  ),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.50), // Shadow color with opacity
                      spreadRadius: 0, // How far the shadow spreads
                      blurRadius: 2, // Softness of the shadow
                      offset: const Offset(0, -5), // Offset to position shadow above the box
                    ),
                  ],
                ),
                child: ListView(
                  children: [

                    Center(child: Text(StringConfig.signIn, style: textSize26.copyWith(fontWeight: FontWeight.w600, color: ColorConfig.whiteColor))),

                    Form(
                      key: formKey,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          Text(StringConfig.email, style: textSize14White.copyWith(color: ColorConfig.whiteColor.withOpacity(0.50)),),
                          const SizedBox(height: 5),
                          CustomTextField(
                            controller: emailController,
                            borderColor: ColorConfig.whiteColor,
                            hintText: StringConfig.email,
                            hintStyle: TextStyle(color: ColorConfig.whiteColor.withOpacity(0.50)),
                            onChanged: (value) {

                            },
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return "Enter your email id";
                              } else if (!(value ?? "").isValidEmail) {
                                return "Enter a valid email id";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),
                          Text(StringConfig.password, style: textSize14White.copyWith(color: ColorConfig.whiteColor.withOpacity(0.50)),),
                          const SizedBox(height: 5),
                          CustomTextField(
                            controller: passwordController,
                            borderColor: ColorConfig.whiteColor,
                            hintText: StringConfig.password,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            hintStyle: TextStyle(color: ColorConfig.whiteColor.withOpacity(0.50)),
                            onChanged: (value) {

                            },
                            validator: (value) {
                              if ((value ?? "").isEmpty) {
                                return "Enter your password";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),
                    if (authState.isLoading)
                      getLoader()
                    else PrimaryButton(
                        btnText: StringConfig.login,
                        btnTextColor: ColorConfig.primaryColor,
                        btnColor: ColorConfig.buttonColorYellow,
                        onPressed: () {
                          final isValid = formKey.currentState!.validate();
                          if (!isValid) {
                            return;
                          }
                          ref.read(authViewModelProvider.notifier).login(emailController.text, passwordController.text);
                        },
                      ),

                    const SizedBox(height: 10),
                    if (authState.hasError) Text(authState.error.toString(), style: const TextStyle(color: Colors.red)),
                    if ((authState.value ?? "").isNotEmpty) Center(child: Text('Logged in successfully! Token: ${authState.value}', style: TextStyle(color: ColorConfig.whiteColor),)),

                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}