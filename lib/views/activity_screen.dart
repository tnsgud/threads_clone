import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<String> _tabText;
  final List<IconData> _icons = [
    Icons.reply_sharp,
    Icons.person,
    Icons.favorite
  ];
  final List<Color> _colors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink
  ];

  void _onTabTap() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _tabText = [
      'All',
      'Replies',
      'Mentions',
      'Quotes',
      'Reposts',
      'Verified',
    ];
    _tabController = TabController(length: _tabText.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v20,
          const Text(
            'Activity',
            style: TextStyle(
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w800,
            ),
          ),
          Gaps.v10,
          TabBar(
            controller: _tabController,
            isScrollable: true,
            dividerColor: Colors.transparent,
            labelPadding: EdgeInsets.zero,
            indicatorColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: (index) => setState(() {}),
            tabs: [
              for (var i = 0; i < _tabText.length; i++)
                _tab(text: _tabText[i], index: i),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => _userItem(),
            ),
          )
        ],
      ),
    );
  }

  Widget _tab({required String text, required int index}) {
    final isSelected = index == _tabController.index;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: AnimatedContainer(
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 10),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(color: isSelected ? Colors.black : Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: Sizes.size20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _userItem() {
    final localFaker = Faker();
    final isFollowing = (Random().nextInt(10) + 1) ~/ 2 == 0;
    final iconIndex = Random().nextInt(4);
    final hour = Random().nextInt(10) + 1;

    return Row(
      children: [
        Stack(
          children: [
            SizedBox(
              width: Sizes.size44,
              height: Sizes.size44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(
                  faker.image.image(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(Sizes.size24, Sizes.size24),
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: _colors[iconIndex],
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.white,
                    width: Sizes.size3,
                  ),
                ),
                child: Center(
                  child: iconIndex == 0
                      ? SizedBox(
                          width: 10,
                          height: 10,
                          child: SvgPicture.asset(
                            'assets/images/threads_logo.svg',
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          _icons[iconIndex - 1],
                          color: Colors.white,
                          size: Sizes.size14,
                        ),
                ),
              ),
            )
          ],
        ),
        Gaps.h10,
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              localFaker.internet.userName(),
                              style: const TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gaps.h5,
                            Text(
                              '${hour}h',
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Text(
                          localFaker.person.name(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: Sizes.size16,
                          ),
                        )
                      ],
                    ),
                    if (isFollowing)
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: Sizes.size10),
                        child: Container(
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Sizes.size8,
                            ),
                            child: Center(
                              child: Text(
                                'Following',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                const Text(
                  'sending message',
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16
              ],
            ),
          ),
        )
      ],
    );
  }
}
