import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/views/settings_screen.dart';

enum Page { first, second }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final faker = Faker();
  Page _showingPage = Page.first;

  void onTap() {
    setState(() {
      _showingPage = _showingPage == Page.first ? Page.second : Page.first;
    });
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return _showingPage == Page.second
            ? []
            : [
                _appBar(),
                SliverPersistentHeader(
                  delegate: Header(
                    tabController: _tabController,
                  ),
                ),
              ];
      },
      body: _showingPage == Page.first
          ? TabBarView(
              controller: _tabController,
              children: const [
                Threads(),
                Replies(),
              ],
            )
          : SettingsScreen(
              // onTap: onTap,
              ),
    );
  }

  SliverAppBar _appBar() {
    return SliverAppBar(
      leading: const Icon(Icons.language),
      actions: [
        SvgPicture.asset('assets/images/instagram.svg'),
        Gaps.h20,
        GestureDetector(onTap: onTap, child: const Icon(Icons.menu))
      ],
    );
  }
}

class Header extends SliverPersistentHeaderDelegate {
  Header({
    required this.tabController,
  });

  final tabController;
  final Faker faker = Faker();
  final faker2 = Faker();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return FractionallySizedBox(
      heightFactor: 1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(faker.person.name()),
                  Gaps.v20,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(faker.internet.userName()),
                      Gaps.h10,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('threads.net'),
                        ),
                      ),
                    ],
                  ),
                  Gaps.v20,
                  const Text('Plant'),
                  Gaps.v20,
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                            offset: const Offset(Sizes.size24, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.white,
                                  width: Sizes.size3,
                                ),
                              ),
                              child: SizedBox(
                                width: Sizes.size44,
                                height: Sizes.size44,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.network(
                                    faker2.image.image(),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Gaps.h36,
                      const Text('2 followers')
                    ],
                  ),
                ],
              ),
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
            ],
          ),
          Gaps.v32,
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      'Edit profile',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Gaps.h11,
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      'Share profile',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          TabBar(
            controller: tabController,
            isScrollable: true,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelPadding: const EdgeInsets.symmetric(horizontal: 80),
            splashFactory: NoSplash.splashFactory,
            tabs: const [
              Text('Threads'),
              Text('Replies'),
            ],
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 300;

  @override
  // TODO: implement minExtent
  double get minExtent => 300;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

class Threads extends StatefulWidget {
  const Threads({super.key});

  @override
  State<Threads> createState() => _ThreadsState();
}

class _ThreadsState extends State<Threads> {
  Faker me = Faker();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.separated(
        itemBuilder: (context, index) => _thread(),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: 10,
      ),
    );
  }

  Widget _thread() {
    var faker1 = Faker();
    var faker2 = Faker();
    var faker3 = Faker();

    bool isImage = Random().nextInt(2) < 1;

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
                        me.image.image(),
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
                          me.internet.userName(),
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
                          onTap: () {},
                          child: const Icon(Icons.more_horiz),
                        )
                      ],
                    ),
                    Gaps.v3,
                    const Text(
                      'hello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello world',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          if (isImage)
            CarouselSlider(
              items: [
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset('assets/images/newjeans1.jpg'),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/newjeans2.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/newjeans3.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
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

class Replies extends StatefulWidget {
  const Replies({super.key});

  @override
  State<Replies> createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => _thread(),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 10,
    );
  }

  Widget _thread() {
    var faker = Faker();
    var faker1 = Faker();
    var faker2 = Faker();
    var faker3 = Faker();

    bool isImage = Random().nextInt(2) < 1;

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
                          onTap: () {},
                          child: const Icon(Icons.more_horiz),
                        )
                      ],
                    ),
                    Gaps.v3,
                    const Text(
                      'hello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello worldhello world',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          if (isImage)
            CarouselSlider(
              items: [
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset('assets/images/newjeans1.jpg'),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/newjeans2.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/newjeans3.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
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
            child: Column(
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
                                onTap: () {},
                                child: const Icon(Icons.more_horiz),
                              )
                            ],
                          ),
                          Gaps.v3,
                          const Text(
                            'replies text',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: Sizes.size20,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
