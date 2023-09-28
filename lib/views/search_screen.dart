import 'dart:developer' as dev;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _originDocs = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs = [];

  @override
  void initState() {
    initData();

    _controller.addListener(() {
      var text = _controller.text;
      _docs = _originDocs
          .where((el) => el.get('content').toString().contains(text))
          .toList();

      dev.log(_docs.toString());

      setState(() {});
    });
    super.initState();
  }

  void initData() async {
    var collection = FirebaseFirestore.instance.collection('threads');
    final list = await collection.get();

    _originDocs = list.docs;
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
            'Search',
            style: TextStyle(
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w800,
            ),
          ),
          Gaps.v10,
          CupertinoSearchTextField(
            controller: _controller,
          ),
          Gaps.v10,
          Expanded(
            child: ListView(
              children: _docs
                  .map(
                    (e) => Text(
                      e.get('content'),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _userItem() {
    final localFaker = Faker();
    final follower = Random().nextInt(200) + 10;
    final isBlueCheck = follower > 150;

    return Row(
      children: [
        SizedBox(
          width: Sizes.size44,
          height: Sizes.size44,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(
              localFaker.image.image(),
              fit: BoxFit.fill,
            ),
          ),
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
                            if (isBlueCheck)
                              SvgPicture.asset('assets/images/blue_check.svg')
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
                              'Follow',
                              style: TextStyle(
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
                Text(
                  '$follower followers',
                  style: const TextStyle(
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
