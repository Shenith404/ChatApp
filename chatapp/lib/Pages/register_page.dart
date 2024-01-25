import 'package:chatapp/Component/colors.dart';
import 'package:chatapp/Component/my_button.dart';
import 'package:chatapp/Component/my_text_field.dart';
import 'package:chatapp/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conformPasswordController = TextEditingController();

  void signUp() async {
    if (passwordController.text != conformPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Passwords are Not match",
            style: TextStyle(color: MyColors.defaultColor),
          ),
        ),
      );
    }

    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.SignUpWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Acount Created",
            selectionColor: MyColors.defaultColor,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  //Icon
                  const Icon(
                    Icons.message,
                    size: 100,
                    color: MyColors.defaultColor,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //welcomeback message
                  const Text("Let's create an Acount",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 20,
                  ),
                  //email textfield
                  MyTextfield(
                      contraller: emailController,
                      hintText: "Email",
                      obscureText: false),
                  //password
                  MyTextfield(
                      contraller: passwordController,
                      hintText: "Password",
                      obscureText: true),
                  //conform password
                  MyTextfield(
                      contraller: conformPasswordController,
                      hintText: "Conform Password",
                      obscureText: true),
                  //sign Up btn
                  MyButton(
                      ontap: signUp,
                      text: "Sing Up",
                      color: MyColors.defaultColor),
                  //not a member ,register now
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already a Member",
                      ),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Sign In Now",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
