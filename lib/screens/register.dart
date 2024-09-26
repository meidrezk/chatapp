import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constant.dart';
import '../helper/show_snackBar.dart';
import '../routes_manager.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;

  String? password;

  GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Constant.kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/images/scholar.png",
                  height: 100,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Center(
                  child: Text(
                    "Scholar Chat",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Email',
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  prefixIcon: Icon(Icons.lock),
                  obscureText: _obscureText,
                  suffixIcon: GestureDetector(
                    onTap: _toggle,
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  hintText: 'Password',
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  text: "Register",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        context.push(AppRouter.chatScreenPath, extra: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                          showSnackBar(context,
                              message: 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                          showSnackBar(context,
                              message:
                                  'The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                        showSnackBar(context, message: '${e.toString()}');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("already have an account? ",
                        style: TextStyle(color: Colors.white)),
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("Login",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
