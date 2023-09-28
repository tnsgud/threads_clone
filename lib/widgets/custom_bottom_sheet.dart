import 'package:flutter/material.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/widgets/report_bottom_sheet.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  void _onReportTap(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      builder: (context) => const ReportBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 300,
      child: Column(
        children: [
          Gaps.v32,
          _button(text: 'Unfollow', isTop: true),
          _button(text: 'Mute', isTop: false),
          Gaps.v10,
          _button(text: 'Hide', isTop: true),
          GestureDetector(
              onTap: () => _onReportTap(context),
              child: _button(text: 'Report', isTop: false, isImportant: true))
        ],
      ),
    );
  }

  Widget _button(
      {required String text, required bool isTop, bool isImportant = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 50,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: isTop
              ? null
              : [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0,
                    offset: Offset(0, -1),
                  ),
                ],
          borderRadius: isTop
              ? const BorderRadius.only(
                  topLeft: Radius.circular(Sizes.size20),
                  topRight: Radius.circular(Sizes.size20),
                )
              : const BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size20),
                  bottomRight: Radius.circular(Sizes.size20),
                ),
        ),
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: Sizes.size20),
          child: Text(
            text,
            style: TextStyle(
                color: isImportant ? Colors.red : Colors.black,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
