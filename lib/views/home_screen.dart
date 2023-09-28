import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/widgets/custom_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> _threadStream =
      FirebaseFirestore.instance.collection('threads').snapshots();

  void _onMoreTap() {
    showModalBottomSheet(
        context: context, builder: (context) => const CustomBottomSheet());
  }

  @override
  void initState() {
    super.initState();

    _permission();
  }

  void _permission() async {
    if (await Permission.camera.isGranted) {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/images/threads_logo.svg'),
        // _thread(),
        // Thread()
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _threadStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs
                    .map(
                      (DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return _thread(
                          content: data['content'],
                          imageUrl: data['imageUrl'],
                        );
                      },
                    )
                    .toList()
                    .cast(),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _thread({required String content, required String imageUrl}) {
    var faker = Faker();
    var faker1 = Faker();
    var faker2 = Faker();
    var faker3 = Faker();

    var urls = imageUrl.split(',');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.white,
                          width: Sizes.size3,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: Sizes.size20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Gaps.h16,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          faker.internet.userName(),
                          style: const TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        const Text(
                          '2m',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Gaps.h5,
                        GestureDetector(
                          onTap: _onMoreTap,
                          child: const Icon(Icons.more_horiz),
                        )
                      ],
                    ),
                    Gaps.v3,
                    Text(
                      content,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          if (urls.first.isNotEmpty)
            CarouselSlider.builder(
              itemCount: urls.length,
              itemBuilder: (context, index, realIndex) {
                return SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(urls[index]),
                  ),
                );
              },
              options: CarouselOptions(
                viewportFraction: 0.9,
                enableInfiniteScroll: false,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: Sizes.size56),
            child: Row(
              children: [
                SizedBox(
                  width: 25,
                  child: SvgPicture.asset(
                    'assets/images/activity.svg',
                    color: Colors.black,
                  ),
                ),
                Gaps.h20,
                SizedBox(
                  width: 25,
                  child: SvgPicture.asset(
                    'assets/images/comment.svg',
                    color: Colors.black,
                  ),
                ),
                Gaps.h20,
                SizedBox(
                  width: 25,
                  child: SvgPicture.asset(
                    'assets/images/repost.svg',
                    color: Colors.black,
                  ),
                ),
                Gaps.h20,
                SizedBox(
                  width: 25,
                  child: SvgPicture.asset(
                    'assets/images/share.svg',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Gaps.v20,
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Transform.translate(
                      offset: const Offset(20, -30),
                      child: SizedBox(
                        width: Sizes.size32,
                        height: Sizes.size32,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            faker1.image.image(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-5, -10),
                      child: SizedBox(
                        width: Sizes.size24,
                        height: Sizes.size24,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            faker2.image.image(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(20, 10),
                      child: SizedBox(
                        width: Sizes.size20,
                        height: Sizes.size20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.network(
                            faker3.image.image(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.h24,
                Text(
                  '${Random().nextInt(100) + 3} replies • ${Random().nextInt(1000) + 1} likes',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: Sizes.size20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
