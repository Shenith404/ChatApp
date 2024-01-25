import 'package:chatapp/Component/colors.dart';
import 'package:chatapp/Component/my_button.dart';
import 'package:chatapp/Component/my_text_field.dart';
import 'package:chatapp/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  final bool animate;
  const LoginPage({
    super.key,
    required this.onTap,
    required this.animate,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in function
  void singIn() async {
    final authservise = Provider.of<AuthService>(context, listen: false);
    try {
      await authservise.SingInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Succsessfull"),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin: EdgeInsets.only(top: 0),
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
                    const Text("Welocome Back", style: TextStyle(fontSize: 20)),
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
                    //sign in btn
                    MyButton(
                        ontap: singIn,
                        text: "Sing In",
                        color: MyColors.defaultColor),
                    //not a member ,register now
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Not a Member ?"),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
