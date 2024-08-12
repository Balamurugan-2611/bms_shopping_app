import 'package:flutter/material.dart';
import 'package:bms_shopping_app/resources/R.dart';
import 'package:bms_shopping_app/resources/resources.dart';
import 'package:bms_shopping_app/route/route_constants.dart';
import 'package:bms_shopping_app/widget/bottom_dialog.dart';
import 'package:bms_shopping_app/widget/loader_widget.dart';

import 'register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RegisterBloc _registerBloc = RegisterBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(
          color: Colors.black, // Change your color here
        ),
        title: Center(
          child: Text(
            R.strings.registerTitle,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: _FirstNameInput(registerBloc: _registerBloc)),
                  SizedBox(width: 10),
                  Expanded(child: _LastNameInput(registerBloc: _registerBloc)),
                ],
              ),
            ),
            SizedBox(height: 10),
            _DobInput(registerBloc: _registerBloc),
            SizedBox(height: 10),
            _EmailInput(registerBloc: _registerBloc),
            SizedBox(height: 10),
            _PasswordInput(registerBloc: _registerBloc),
            SizedBox(height: 20),
            _SubmitRegister(registerBloc: _registerBloc),
          ],
        ),
      ),
    );
  }

  void createSnackBar(String message) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}

class _SubmitRegister extends StatelessWidget {
  final RegisterBloc registerBloc;

  const _SubmitRegister({required this.registerBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: registerBloc.validateResult$,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: () async {
            if (snapshot.data == true) {
              showModalBottomSheet(
                context: context,
                elevation: 30,
                backgroundColor: Colors.transparent,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: LoaderPage()),
                ),
              );

              final success = await registerBloc.register();

              if (success) {
                Navigator.pushReplacementNamed(context, RouteConstant.loginRoute);
              } else {
                print('Register failed');
              }
            } else {
              print('Invalid form');
            }
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            primary: AppColors.indianRed,
          ),
          child: Text(
            R.strings.registerTitle,
            style: whiteText,
          ),
        );
      },
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  final RegisterBloc registerBloc;

  const _FirstNameInput({required this.registerBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: registerBloc.firstName$,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: registerBloc.onFirstNameChanged,
          decoration: InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            errorText: snapshot.hasData && !snapshot.data! ? 'Required field' : null,
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  final RegisterBloc registerBloc;

  const _LastNameInput({required this.registerBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: registerBloc.lastName$,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: registerBloc.onLastNameChanged,
          decoration: InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            errorText: snapshot.hasData && !snapshot.data! ? 'Required field' : null,
          ),
        );
      },
    );
  }
}

class _DobInput extends StatefulWidget {
  final RegisterBloc registerBloc;

  const _DobInput({required this.registerBloc});

  @override
  __DobInputState createState() => __DobInputState();
}

class __DobInputState extends State<_DobInput> {
  final TextEditingController _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.registerBloc.dob$,
      builder: (context, snapshot) {
        return TextFormField(
          controller: _dobController,
          onChanged: widget.registerBloc.onDobChanged,
          readOnly: true,
          decoration: InputDecoration(
            labelText: R.strings.dob,
            border: OutlineInputBorder(),
            errorText: snapshot.hasData && !snapshot.data! ? 'Required field' : null,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          ),
          onTap: () => _selectDate(context),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dobController.text = selectedDate.toLocal().toString().split(' ')[0];
        widget.registerBloc.changeDob(_dobController.text);
      });
    }
  }
}

class _EmailInput extends StatelessWidget {
  final RegisterBloc registerBloc;

  const _EmailInput({required this.registerBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: registerBloc.email$,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: registerBloc.onEmailChanged,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            errorText: snapshot.hasData && !snapshot.data! ? 'Enter a valid email address' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final RegisterBloc registerBloc;

  const _PasswordInput({required this.registerBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: registerBloc.password$,
      builder: (context, snapshot) {
        return TextFormField(
          onChanged: registerBloc.onPasswordChanged,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            errorText: snapshot.hasData && !snapshot.data! ? 'Invalid password, please enter more than 4 characters' : null,
          ),
        );
      },
    );
  }
}
