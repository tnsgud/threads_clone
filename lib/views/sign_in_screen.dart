import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  void _onLogInTap() async {
    var email = _emailController.text;
    var password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      context.go('/');
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void _onCreateAccountTap() => context.go('/create-account');

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size32,
              horizontal: Sizes.size20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('English'),
                  ],
                ),
                Gaps.v72,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(Sizes.size16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.size10),
                    child: SvgPicture.asset(
                      'assets/images/threads_logo.svg',
                      width: Sizes.size56,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Gaps.v72,
                Gaps.v32,
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                Gaps.v16,
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                Gaps.v16,
                GestureDetector(
                  onTap: _onLogInTap,
                  child: Container(
                    width: double.infinity,
                    height: Sizes.size60,
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(Sizes.size5),
                    ),
                    child: const Center(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Gaps.v20,
                const Text(
                  'Forgot password?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _onCreateAccountTap,
                  child: Container(
                    width: double.infinity,
                    height: Sizes.size44,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: const Center(
                      child: Text(
                        'Create new account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size14,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
