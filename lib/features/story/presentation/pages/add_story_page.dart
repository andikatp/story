import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/services/router.dart';
import 'package:story/features/story/presentation/bloc/story_bloc.dart';
import 'package:story/features/story/presentation/widgets/location_widget.dart';
import 'package:story/features/story/presentation/widgets/text_field_story.dart';

class AddStoryPage extends StatelessWidget {
  const AddStoryPage({required this.image, super.key});
  final XFile image;

  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();
    LatLng? userLocation;

    void setIsLocationOn({required LatLng? location}) =>
        userLocation = location;

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
              file: image,
              description: description,
              location: userLocation,
            ),
          );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(
            File(image.path),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: context.pop,
            iconSize: 44.sp,
          ),
          actions: [LocationWidget(setIsLocationOn: setIsLocationOn)],
        ),
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
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TextFieldStory(
              descriptionController: descriptionController,
              addStory: addStory,
            ),
          ),
        ),
      ),
    );
  }
}
