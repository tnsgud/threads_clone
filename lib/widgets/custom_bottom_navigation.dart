import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/widgets/custom_circle_avatar.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  static int _index = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final ImagePicker picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();
  List<XFile> _images = [];
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance.ref();

  final List<String> _defaultImagePaths = [
    'home',
    'search',
    'write',
    'activity',
    'profile'
  ];
  final List<String> _path = ['/', '/search', '', '/activity', '/profile'];

  void _onPostTap() async {
    var imageUrls = [];
    var text = _controller.text;
    var collection = db.collection('threads');
    var ref = storage.child('${DateTime.now().millisecondsSinceEpoch}');

    for (var i in _images) {
      await ref.putFile(File(i.path)).whenComplete(() => null);
      var url = await ref.getDownloadURL();
      imageUrls.add(url);
    }

    collection.add({'content': text, 'imageUrl': imageUrls.join(',')});

    context.pop();
  }

  void _showWriteSheet() {
    _controller.text = '';
    _images = [];
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SizedBox(
          height: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Text(
                      'New thread',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.transparent,
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size12,
                    vertical: Sizes.size20,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  CustomCircleAvatar(
                                    width: Sizes.size40,
                                    height: Sizes.size40,
                                    backgroundImage: NetworkImage(
                                      faker.image.image(),
                                    ),
                                  ),
                                  Gaps.v5,
                                  Flexible(
                                    flex: 5,
                                    child: Container(
                                      width: Sizes.size3,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                  Gaps.v5,
                                  CustomCircleAvatar(
                                    width: Sizes.size20,
                                    height: Sizes.size20,
                                    backgroundImage: NetworkImage(
                                      faker.image.image(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Gaps.h10,
                            Flexible(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'anonmyous',
                                        style: TextStyle(
                                          fontSize: Sizes.size16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Icon(Icons.close)
                                    ],
                                  ),
                                  TextField(
                                    controller: _controller,
                                    maxLines: 3,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final image =
                                          await picker.pickMultiImage();

                                      setState(
                                        () {
                                          _images = image;
                                        },
                                      );
                                    },
                                    child:
                                        const Icon(Icons.attach_file_rounded),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.v10,
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Image.file(
                              File(_images[index].path),
                              width: 200,
                              height: 150,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Gaps.v10,
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Anyone can reply'),
                            CupertinoButton(
                              onPressed: _onPostTap,
                              child: const Text(
                                'Post',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTap(int index) {
    if (index == 2) {
      _showWriteSheet();
      return;
    }

    setState(() {
      _index = index;
      context.go(_path[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTap,
        items: [
          for (var i = 0; i < _defaultImagePaths.length; i++)
            _item(index: i, path: _defaultImagePaths[i])
        ],
      ),
    );
  }

  BottomNavigationBarItem _item({required int index, required String path}) {
    return BottomNavigationBarItem(
      label: '',
      icon: SizedBox(
        width: Sizes.size28,
        child: SvgPicture.asset(
          'assets/images/$path${_index == index ? '_select' : ''}.svg',
        ),
      ),
    );
  }
}
