import 'package:flutter/material.dart';
import 'package:book_grocer/http_service.dart';
import 'package:book_grocer/view/main_tab/main_tab_view.dart';
import 'package:book_grocer/common/color_extenstion.dart';
import 'package:book_grocer/view/login/forgot_password_view.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController txtCode = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isStay = false;
  final HttpService _httpService = HttpService();

  void _login() async {
    try {
      final response = await _httpService.login(
        _usernameController.text,
        _passwordController.text,
      );

      print('Login API Response: $response'); // Debugging statement

      if (response['success']) {
        print('Login successful: $response');

        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text(response['message']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    
                    // Navigate to MainTabView after successful login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainTabView()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Show error message from server
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message']),
          ),
        );
      }
    } catch (e) {
      // Show general error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
      print('Login failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColor.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                  color: TColor.text,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              RoundTextField(
                controller: txtCode,
                hintText: "Optional Group Special Code",
              ),
              const SizedBox(height: 15),
              RoundTextField(
                controller: _usernameController,
                hintText: "Username",
              ),
              const SizedBox(height: 15),
              RoundTextField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isStay = !isStay;
                      });
                    },
                    icon: Icon(
                      isStay ? Icons.check_box : Icons.check_box_outline_blank,
                      color: isStay
                          ? TColor.primary
                          : TColor.subTitle.withOpacity(0.3),
                    ),
                  ),
                  Text(
                    "Stay Logged In",
                    style: TextStyle(
                      color: TColor.subTitle.withOpacity(0.3),
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordView(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Your Password?",
                      style: TextStyle(
                        color: TColor.subTitle.withOpacity(0.3),
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              RoundLineButton(
                title: "Sign In",
                onPressed: _login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
