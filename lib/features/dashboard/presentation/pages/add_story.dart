import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddStory extends StatelessWidget {
  const AddStory({super.key});

  @override
  Widget build(BuildContext context) {
    final img = GoRouterState.of(context).extra! as XFile;
    final descriptionController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Image.file(
              File(img.path),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 20,
            child: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: context.pop,
              iconSize: 44.sp,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.black38,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: TextField(
                controller: descriptionController,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                maxLines: 6,
                minLines: 1,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add Caption....',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  suffixIcon: CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.tealAccent[700],
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
