import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/app_config.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/res/colours.dart';
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

    void setIsLocation({required LatLng? location}) => userLocation = location;

    void clearAndNavigate(String path) {
      while (context.canPop() == true) {
        context.pop();
      }
      context.pushReplacementNamed(path);
    }

    Future<void> addStory() async {
      final description = descriptionController.text.trim();
      if (description.isEmpty) {
        await Flushbar<dynamic>(
          message: 'CaptionEmpty'.tr(),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colours.primaryColor,
          duration: const Duration(seconds: 1),
          flushbarStyle: FlushbarStyle.GROUNDED,
        ).show(context);
      } else {
        context.read<StoryBloc>().add(
              AddStoryEvent(
                file: image,
                description: description,
                location: userLocation,
              ),
            );
      }
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
          actions: [
            if (AppConfig.shared.flavor == Flavor.paid)
              LocationWidget(setIsLocation: setIsLocation),
          ],
        ),
        body: BlocListener<StoryBloc, StoryState>(
          listener: (context, state) {
            if (state is StoryError) {
              context.pop();
              context.messengger.showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
            if (state is StoryAdded) {
              clearAndNavigate(Routes.dashboard.name);
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
