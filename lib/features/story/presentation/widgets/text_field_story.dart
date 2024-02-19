import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldStory extends StatelessWidget {
  const TextFieldStory({
    required this.descriptionController,
    required this.addStory,
    super.key,
  });

  final TextEditingController descriptionController;
  final VoidCallback addStory;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: TextField(
        controller: descriptionController,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
        maxLines: 3,
        minLines: 1,
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'AddCaption'.tr(),
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 17.sp,
          ),
          suffixIcon: IconButton(
            onPressed: addStory,
            style: IconButton.styleFrom(
              backgroundColor: Colors.tealAccent[700],
            ),
            icon: Icon(
              Icons.check,
              color: Colors.white,
              size: 27.sp,
            ),
          ),
        ),
      ),
    );
  }
}
