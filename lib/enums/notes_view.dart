import 'package:flutter/material.dart';

import '../constants/routes_view.dart';
import '../services/auth/auth_service.dart';
import 'menu_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      actions: [
        PopupMenuButton(onSelected: (value) async {
          switch (value) {
            case MenuAction.logout:
              final shouldLogout = await showLogOutDialogue(context);
              if (shouldLogout) {
                await AuthService.firebase().logOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (_) => false);
              }
          }
        }, itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: MenuAction.logout,
              child: Text('Logout'),
            ),
          ];
        }),
      ],
      title: Text('Notes'),
    ));
  }
}

Future<bool> showLogOutDialogue(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Logout'),
      content: Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    ),
  ).then((value) => value ?? false);
}
