// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:bms_shopping_app/feature/auth/login/bloc/login_bloc.dart';
import 'package:bms_shopping_app/resources/R.dart';
import 'package:bms_shopping_app/resources/resources.dart';
import 'package:bms_shopping_app/route/route_constants.dart';
import 'package:bms_shopping_app/widget/appbar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Updated
      appBar: CommonAppBar(title: R.strings.loginTitle),
      body: bodyContent(),
    );
  }

  Widget bodyContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30.0,
          ),
          _EmailInput(),
          SizedBox(
            height: 15.0,
          ),
          _PasswordInput(),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.topRight,
              child: Text(R.strings.forgotPassword)),
          SizedBox(
            height: 70,
          ),
          _SubmitLogin(),
          SizedBox(
            height: 18.0,
          ),
          Center(
            child: RichText(
                text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: minorText,
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                              context, RouteConstant.registerRoute);
                        },
                      text: 'Register',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline))
                ])),
          ),
          SizedBox(
            height: 50.0,
          ),
          Center(child: Text('Or Login with')),
          SizedBox(
            height: 30.0,
          ),
          _loginWithSocialNetwork(), // Fixed typo
        ],
      ),
    );
  }

  Widget _loginWithSocialNetwork() { // Fixed typo
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              primary: AppColors.cornflowerBlue, // Updated color property
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Ionicons.logo_facebook,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  R.strings.facebook,
                  style: whiteText,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              primary: AppColors.indianRed, // Updated color property
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Ionicons.logo_google,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  R.strings.google,
                  style: whiteText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void login() async {}

  void createSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message))); // Updated
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return previous.email != current.email;
      },
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email,
          onChanged: (value) =>
              context.read<LoginBloc>().add(EmailChanged(email: value)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: 'Email',
              helperText: '',
              icon: const Icon(Icons.email),
              errorText: state.isEmailInvalid != null && state.isEmailInvalid
                  ? 'Invalid email'
                  : null),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password,
          onChanged: (value) =>
              context.read<LoginBloc>().add(PasswordChanged(password: value)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            icon: const Icon(Icons.lock),
            errorText: state.isPasswordInvalid != null && state.isPasswordInvalid
                ? 'Invalid password'
                : null,
          ),
        );
      },
    );
  }
}

class _SubmitLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFinishedState) {
            if (state.isSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteConstant.homeRoute, (r) => false);
            }
          }
        },
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            primary: AppColors.indianRed, // Updated color property
          ),
          onPressed: () {
            context.read<LoginBloc>().add(Submitted());
          },
          child: Text(
            R.strings.loginTitle,
            style: whiteText,
          ),
        ));
  }
}
