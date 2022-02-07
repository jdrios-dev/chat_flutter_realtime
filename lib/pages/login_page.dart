import 'package:chat/helpers/show_alert.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/widgets/btn_blue.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Logo(),
                _Form(),
                Labels(
                  linkLabel: 'Create a new one',
                  mainLabel: 'I dont have an account',
                  routeName: 'register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  __FromState createState() => __FromState();
}

class __FromState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.password_outlined,
            placeholder: 'Password',
            keyboardType: TextInputType.visiblePassword,
            textController: passCtrl,
            isPassword: true,
          ),
          //TODO: BUTTON
          BtnBlue(
            text: 'Login',
            onPress: authService.isAuthing
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginOk) {
                      // TODO: connect socket server

                      Navigator.pushReplacementNamed(context, 'users');
                    } else {
                      showAlert(context, 'What Happend!? :( ',
                          'Credentials are incorrect...');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
