import 'package:flame_game/presentation/controllers/auth_controller.dart';
import 'package:flame_game/presentation/widgets/button_widget.dart';
import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flame_game/presentation/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../routes/app_routes.dart';

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
                left: Get.width / 3.3,
                top: 10,
                child: Align(
                  alignment: Alignment.center,
                  child: CustomCard(
                    width: Get.width * 0.4,
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CustomInput(
                              hintText: 'Ton nom d\'utilisateur',
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: 15,
                              controller: userNameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CustomInput(
                              hintText: 'Ton mot de passe',
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: 15,
                              controller: passwordController,
                            ),
                          ),
                          const SizedBox(height: 5),
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
                                  SizedBox(
                                    height: 30,
                                    child: RadioListTile(
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
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: RadioListTile(
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
                                  )
                                ],
                              );
                            },
                          ),
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
                              const SizedBox(width: 5),
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
                left: Get.width / 3.3,
                top: Get.height / 1.25,
                child: CustomGameButton(
                  width: Get.width * 0.4,
                  text: "Continuer sans compte",
                  onPressed: () {
                    authController.continueAsGuest();
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
