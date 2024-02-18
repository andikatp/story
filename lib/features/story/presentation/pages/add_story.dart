import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/services/router.dart';
import 'package:story/features/story/presentation/bloc/story_bloc.dart';
import 'package:story/features/story/presentation/widgets/text_field_story.dart';

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
          SnackBar(
            content: const Text('CaptionEmpty').tr(),
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
            context.pop();
          }
          if (state is StoryAdded) {
            context.replaceNamed(Routes.dashboard.name);
            context.messengger.showSnackBar(
              SnackBar(
                content: const Text('StoryAdded').tr(),
                behavior: SnackBarBehavior.floating,
              ),
            );
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
            TextFieldStory(
              descriptionController: descriptionController,
              addStory: addStory,
            ),
          ],
        ),
      ),
    );
  }
}
