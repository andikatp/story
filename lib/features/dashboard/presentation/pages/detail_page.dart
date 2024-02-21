import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';
import 'package:story/features/dashboard/presentation/pages/map_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({required this.story, super.key});

  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(story.name),
        titleTextStyle:
            context.titleSmall.copyWith(color: Colours.primaryColor),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            key: key,
            imageUrl: story.photoUrl,
            height: 1.sh,
            width: 1.sw,
            fit: BoxFit.cover,
            placeholder: (_, __) => const Center(
              child: CupertinoActivityIndicator(),
            ),
            errorWidget: (_, __, ___) => const Icon(Icons.error),
            cacheManager: CacheManager(
              Config(
                'story',
                stalePeriod: const Duration(minutes: 5),
              ),
            ),
          ),
          Align(
            child: Container(
              color: Colours.primaryColor.withOpacity(0.8),
              padding: REdgeInsets.all(Sizes.p8),
              width: 1.sw,
              child: ReadMoreText(
                story.description,
                textAlign: TextAlign.center,
                trimLines: 1,
                trimMode: TrimMode.Line,
                moreStyle: const TextStyle(color: Colours.backgroundColor),
                lessStyle: const TextStyle(color: Colours.backgroundColor),
                trimCollapsedText: 'ReadMore'.tr(),
                trimExpandedText: 'ShowLess'.tr(),
              ),
            ),
          ),
          if (story.lat != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: OpenContainer(
                openColor: Colours.backgroundColor,
                closedColor: Colours.backgroundColor,
                openShape: const CircleBorder(),
                closedBuilder: (context, action) => ElevatedButton.icon(
                  onPressed: action,
                  icon: const Icon(Icons.location_on),
                  label: const Text('Show Location'),
                  style: ElevatedButton.styleFrom(
                    shape: const BeveledRectangleBorder(),
                  ),
                ),
                openBuilder: (context, action) =>
                    MapPage(location: LatLng(story.lat!, story.lon!)),
              ),
            ),
        ],
      ),
    );
  }
}
