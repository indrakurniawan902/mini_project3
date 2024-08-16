import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:indie_commerce/navigation/app_routes.dart';
import 'package:indie_commerce/screen/register/cubit/register_cubit.dart';
import 'package:indie_commerce/screen/widget/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    //hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool textfieldPw = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Register success"),
                backgroundColor: Colors.green));
            context.goNamed(AppRoutes.nrNavbar);
          } else if (state is RegisterEror) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error), backgroundColor: Colors.red));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/logo.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Start finding the best products here!",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 78,
                  ),
                  const Text("Username",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomTextfield(
                    hintText: "Username",
                    textEditingController: _usernameController,
                  ),
                  const SizedBox(height: 24),
                  const Text("Email",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  CustomTextfield(
                    hintText: "Email",
                    isEmail: true,
                    textEditingController: _emailController,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  CustomTextfield(
                    hintText: "Password",
                    suffixIcon: textfieldPw == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    textEditingController: _passwordController,
                    isVisible: textfieldPw,
                    onPressed: () {
                      setState(() {
                        textfieldPw = !textfieldPw;
                      });
                    },
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 46,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<RegisterCubit>().registerUser(
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            if (state is RegisterLoading) {
                              return const CircularProgressIndicator(
                                color: Colors.white,
                              );
                            } else {
                              return const Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              );
                            }
                          },
                        )),
                  ),
                     const SizedBox(height: 48),
                  const Center(
                      child: Text(
                    "Have an Account ?",
                    style: TextStyle(fontSize: 14),
                  )),
                  SizedBox(
                      height: 46,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            context.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
