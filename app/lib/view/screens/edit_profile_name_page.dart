import 'package:app/view/widgets/custom_appbar.dart';
import 'package:app/view/widgets/custom_navbar.dart';
import 'package:app/view/widgets/custom_input.dart';
import 'package:app/view/widgets/custom_big_button.dart';
import '../../view-model/services/update_service.dart';
import '../../view-model/utils/token.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../styles/app_colors.dart';
import 'dart:convert';

class EditNameEmailPage extends StatelessWidget {
  EditNameEmailPage({super.key});
  final AppColors _appColors = Get.find();
  final TextEditingController _nameController = TextEditingController();
  dynamic sendToken = "";
  dynamic req = "";
  dynamic param = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // recupera o foco atual e o remove
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: _appColors.backgroundColor.value,
        appBar: CustomAppBar(),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Ícone e nome do grupo
                      const Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: RichText(
                          text: TextSpan(
                            text: 'Nome do Usuário',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 30,
                              color: _appColors.textColor.value,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Itens do Menu
                CustomInput(
                  inputTittle: 'Novo Nome do Usuário:',
                  controller: _nameController,
                ),

                //Botão de salvar
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: CustomBigButton(
                    tittleBtn: 'SALVAR',
                    customMargin: 70,
                    function: () async {
                      if (_nameController.text.isEmpty) {
                        print('aqui');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Por favor, preencha o novo nome do usuário.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else {
                        sendToken = Get.find<Token>().token;
                        req = {"nick": _nameController.text};
                        String reqString = jsonEncode(req);
                        param = "Nome de Usuário";
                        update(
                            sendToken, reqString, param, _nameController.text);
                      }
                    },
                  ),
                ),
              ],
            ),

            //Botão de voltar
            Positioned(
              top: 10,
              left: 16,
              child: SizedBox(
                width: 40,
                child: FloatingActionButton(
                  backgroundColor: _appColors.redColor.value,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back, size: 30),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavBar(),
      ),
    );
  }
}
