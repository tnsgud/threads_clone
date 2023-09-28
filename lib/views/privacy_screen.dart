import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';

class Privacy extends StatefulWidget {
  Privacy({super.key, required this.onTap});

  void Function() onTap;

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  final List<IconData> _icons = [
    Icons.lock,
    Icons.alternate_email,
    Icons.notifications_off_outlined,
    Icons.visibility_off_outlined,
    Icons.people
  ];
  final List<String> _title = [
    'Private profile',
    'Metions',
    'Muted',
    'Hidden Word',
    'Profiles you follow'
  ];
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: widget.onTap, child: const Text('< Back')),
            const Text('Settings'),
            Gaps.h60
          ],
        ),
        for (var i = 0; i < _icons.length; i++)
          ListTile(
            leading: Icon(_icons[i]),
            title: Text(_title[i]),
            trailing: i == 0
                ? CupertinoSwitch(
                    activeColor: Colors.black,
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    })
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (i == 1)
                        const Text(
                          'Everyone ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      const Text(
                        '>',
                        style: TextStyle(fontSize: Sizes.size32),
                      ),
                    ],
                  ),
          ),
        const Divider(),
        const ListTile(
            title: Text(
              'Other privacy settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.open_in_new),
            subtitle: Text(
                'Some settings, like restrict, apply to both\nThreads and Instagram and can be managed\non Instagram.')),
        const ListTile(
          leading: Icon(Icons.highlight_off),
          title: Text('Blocked profiles'),
          trailing: Icon(Icons.open_in_new),
        ),
        const ListTile(
          leading: Icon(Icons.heart_broken),
          title: Text('Hide likes'),
          trailing: Icon(Icons.open_in_new),
        ),
      ],
    );
  }
}
