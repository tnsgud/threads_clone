import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/constants/gaps.dart';

enum Page { first, second }

class SettingsScreen extends ConsumerWidget {
  final Page _showingPage = Page.first;

  final List<IconData> _icons = [
    Icons.person_add,
    Icons.notifications,
    Icons.lock,
    Icons.account_circle_outlined,
    Icons.help,
    Icons.info
  ];

  final List<String> _title = [
    'Follow and invite friends',
    'Notifications',
    'Privacy',
    'Account',
    'Help',
    'About'
  ];

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Text('< Back'),
                ),
                const Text('Settings'),
                Gaps.h60
              ],
            ),
            for (var i = 0; i < _icons.length; i++)
              ListTile(
                // onTap: i == 2 ? _onTap : null,
                leading: Icon(_icons[i]),
                title: Text(_title[i]),
              ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('Log out?'),
                            actions: [
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                isDestructiveAction: true,
                                child: const Text('Yes'),
                              )
                            ],
                          );
                        });
                  },
                  child: const Text('Log out'),
                ),
                const Icon(Icons.refresh)
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text('Dark mode'),
            //     CupertinoSwitch(
            //       value: userConfig.isDarkMode,
            //       onChanged: (value) {
            //         setState(() {
            //           userConfig.isDarkMode = value;
            //         });
            //       },
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
