import 'dart:io';

import 'package:charm/representation/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'catalog_view.dart';
import 'signin_bloc.dart';
import 'util.dart';

class SigninView extends StatelessWidget {
  SigninView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninBloc(SigninState()),
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
                "Sign In",
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
                  context.read<SigninBloc>().updateEmail(value);
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
                  context.read<SigninBloc>().updatePassword(value);
                },
              ),
              FilledButton(
                onPressed: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      await context.read<SigninBloc>().signin();
                      replaceView(context, CatalogView());
                    }
                  } on HttpException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
                  }
                },
                child: Text("Signin"),
              ),
              OutlinedButton(
                onPressed: () {
                  pushView(context, SignupView());
                },
                child: Text("Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
