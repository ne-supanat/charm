import 'dart:io';

import 'package:charm/representation/signin/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../catalog/catalog_view.dart';
import 'signup_bloc.dart';
import '../util.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(SignupState()),
      child: Builder(
        builder: (context) {
          return buildContent(context);
        },
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBEBEB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  context.read<SignupBloc>().updateEmail(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) {
                  context.read<SignupBloc>().updatePassword(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) {
                  context.read<SignupBloc>().updateConfirmPassword(value);
                },
                validator: (value) {
                  return value == context.read<SignupBloc>().state.password ? null : "Not Matched";
                },
              ),
              FilledButton(
                onPressed: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      await context.read<SignupBloc>().signup();
                      replaceView(context, CatalogView());
                    }
                  } on HttpException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
                  }
                },
                child: Text("Signup"),
              ),
              OutlinedButton(
                onPressed: () {
                  replaceView(context, SigninView());
                },
                child: Text("Signin"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
