// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fourth_app/services/auth/auth_service.dart';

import '../constants/routes_view.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Column(
        children: [
          Text('Please check your email for a verification link.'),
          Text('If you did not receive the email, please click the button'),
          TextButton(
            child: Text('Send Email Verification'),
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
          ),
          TextButton(
            child: Text('Restart'),
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
