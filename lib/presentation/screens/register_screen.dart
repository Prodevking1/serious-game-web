import 'package:flame_game/presentation/controllers/auth_controller.dart';
import 'package:flame_game/presentation/widgets/button_widget.dart';
import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flame_game/presentation/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../routes/router.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  final ValueNotifier<String> genderValue =
      ValueNotifier<String>('Influenceur');

  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AppMedia.mapImage,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: Get.width / 3,
                top: Get.height / 3.8,
                child: Align(
                  alignment: Alignment.center,
                  child: CustomCard(
                    width: Get.width * 0.3,
                    padding: const EdgeInsets.all(50),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Expanded(
                              child: CustomInput(
                                hintText: 'Ton nom d\'utilisateur',
                                backgroundColor:
                                    AppColors.tertiaryColor.withOpacity(0.8),
                                borderRadius: 15,
                                controller: userNameController,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Expanded(
                              child: CustomInput(
                                hintText: 'Ton mot de passe',
                                backgroundColor:
                                    AppColors.tertiaryColor.withOpacity(0.8),
                                borderRadius: 15,
                                controller: passwordController,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Quel est ton genre?',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          ValueListenableBuilder<String>(
                            valueListenable: genderValue,
                            builder: (context, value, child) {
                              return Column(
                                children: [
                                  RadioListTile(
                                    title: const Text(
                                      'M',
                                    ),
                                    value: 'M',
                                    groupValue: value,
                                    onChanged: (val) {
                                      genderValue.value = val as String;
                                    },
                                    activeColor: AppColors.primaryColor,
                                  ),
                                  RadioListTile(
                                    title: const Text(
                                      'F',
                                    ),
                                    value: 'F',
                                    groupValue: value,
                                    onChanged: (val) {
                                      genderValue.value = val as String;
                                    },
                                    activeColor: AppColors.primaryColor,
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: CustomGameButton(
                                  text: "Inscription",
                                  onPressed: () {
                                    singUp();
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomGameButton(
                                  text: "Connexion",
                                  onPressed: () {
                                    login();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: Get.width / 3,
                top: Get.height / 1.2,
                child: CustomGameButton(
                  width: Get.width * 0.3,
                  text: "Continuer sans compte",
                  onPressed: () {
                    Get.toNamed(AppRouter.homePage);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void singUp() async {
    await authController.signUp(
        email: userNameController.text,
        password: passwordController.text,
        gender: genderValue.value);
  }

  void login() async {
    await authController.signIn(
        email: userNameController.text, password: passwordController.text);
  }
}
