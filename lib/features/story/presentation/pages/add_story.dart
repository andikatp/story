import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/services/router.dart';
import 'package:story/features/story/presentation/bloc/story_bloc.dart';

class AddStory extends StatelessWidget {
  const AddStory({super.key});

  @override
  Widget build(BuildContext context) {
    final img = GoRouterState.of(context).extra! as XFile;
    final descriptionController = TextEditingController();

    void addStory() {
      final description = descriptionController.text.trim();
      if (description.isEmpty) {
        context.messengger.showSnackBar(
          const SnackBar(
            content: Text('Please Input Description'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      context.read<StoryBloc>().add(
            AddStoryEvent(
              file: img,
              description: description,
              lat: null,
              lon: null,
            ),
          );
    }

    return Scaffold(
      body: BlocListener<StoryBloc, StoryState>(
        listener: (context, state) {
          if (state is StoryError) {
            context.messengger.showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.goNamed(Routes.dashboard.name);
          }
          if (state is StoryAdded) {
            context.messengger.showSnackBar(
              const SnackBar(
                content: Text('Status has been uploaded successfully!'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.pushReplacementNamed(Routes.dashboard.name);
          }
        },
        child: Stack(
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
                    suffixIcon: IconButton(
                      onPressed: addStory,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.tealAccent[700],
                      ),
                      icon: const Icon(
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
      ),
    );
  }
}
