import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';

class ReportBottomSheet extends StatelessWidget {
  const ReportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Report',
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Why are you reporting this thread?',
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v10,
                  Text(
                    'Your report is anonymous, except if you\'re reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don\'t wait.',
                    style:
                        TextStyle(color: Colors.grey, fontSize: Sizes.size16),
                  ),
                ],
              ),
            ),
            Divider(),
            CupertinoListTile(
              title: Text('I just don\'t like it'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            Divider(),
            CupertinoListTile(
                title: Text('It\'s unlawful content under NetzDG'),
                trailing: Icon(Icons.arrow_forward_ios_rounded)),
            Divider(),
            CupertinoListTile(
                title: Text('It\'s spam'),
                trailing: Icon(Icons.arrow_forward_ios_rounded)),
            Divider(),
            CupertinoListTile(
                title: Text('Hate speech or symbols'),
                trailing: Icon(Icons.arrow_forward_ios_rounded)),
            Divider(),
            CupertinoListTile(
                title: Text('Nudity or sexual activity'),
                trailing: Icon(Icons.arrow_forward_ios_rounded)),
            Divider(),
            CupertinoListTile(
                title: Text('I don\' knows'),
                trailing: Icon(Icons.arrow_forward_ios_rounded)),
            Divider(),
          ],
        ),
      ),
    );
  }
}
