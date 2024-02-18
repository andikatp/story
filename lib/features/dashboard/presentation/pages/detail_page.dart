import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({required this.story, super.key});

  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
          iconSize: Sizes.p44.sp,
          color: Colours.backgroundColor,
        ),
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            key: key,
            imageUrl: story.photoUrl,
            height: 1.sh,
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
              color: Colors.grey.withOpacity(0.8),
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
        ],
      ),
    );
  }
}
