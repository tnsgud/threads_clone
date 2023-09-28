import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatefulWidget {
  final bool isPicked;

  const ImagePreviewScreen({
    super.key,
    required this.isPicked,
  });

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Preview video'),
      ),
    );
  }
}
