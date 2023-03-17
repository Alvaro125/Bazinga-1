import 'package:app/view/widgets/custom_big_input.dart';
import 'package:app/view/widgets/custom_appbar.dart';
import 'package:app/view/widgets/custom_navbar.dart';
import 'package:app/view/widgets/custom_big_button.dart';
import 'package:app/model/feed_functions/new_post.dart';
import '../../view-model/services/new_post_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../styles/app_colors.dart';
import '../../model/authentication/token.dart';

class NewPostPage extends StatelessWidget {
  NewPostPage({super.key});
  final TextEditingController _postController = TextEditingController();
  dynamic sendToken = "";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppColors>(
      init: AppColors(),
      builder: (_) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: CustomAppBar(),
            resizeToAvoidBottomInset: false,
            backgroundColor: _.backgroundColor,
            body: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30, bottom: 50),
                child: Column(
                  children: [
                    CustomBigInput(
                      inputTittle: 'Nova Publicação:',
                      controller: _postController,
                    ),
                    const Spacer(),
                    GetBuilder<Token>(
                      builder: (token) => CustomBigButton(
                        tittleBtn: 'PUBLICAR',
                        customMargin: 15,
                        function: () => {
                          sendToken = Get.find<Token>().token,
                          new_post(_postController.text, sendToken),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: CustomNavBar(),
          ),
        );
      },
    );
  }
}
