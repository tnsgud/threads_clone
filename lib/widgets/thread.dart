import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/widgets/custom_circle_avatar.dart';

class Thread extends StatelessWidget {
  const Thread({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCircleAvatar(
                  width: Sizes.size48,
                  height: Sizes.size48,
                  backgroundImage: NetworkImage(faker.image.image()),
                ),
                Gaps.v5,
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Gaps.v5,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
