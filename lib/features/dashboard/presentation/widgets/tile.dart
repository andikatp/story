import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';
import 'package:story/features/dashboard/presentation/pages/detail_page.dart';

class Tile extends StatelessWidget {
  const Tile({required this.story, required this.extent, super.key});

  final int extent;
  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    // Future<dynamic> showDetail() {
    //   return showDialog(
    //     context: context,
    //     builder: (context) {
    //       return BackdropFilter(
    //         filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
    //         child: AlertDialog(
    //           contentPadding: EdgeInsets.zero,
    //           content: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Container(
    //                 height: 60.h,
    //                 padding: REdgeInsets.symmetric(horizontal: 20),
    //                 child: Wrap(
    //                   spacing: 4,
    //                   runAlignment: WrapAlignment.center,
    //                   crossAxisAlignment: WrapCrossAlignment.center,
    //                   children: [
    //                     Text(
    //                       story.name,
    //                       style: context.bodyMedium,
    //                     ),
    //                     const Icon(Icons.circle, size: 4),
    //                     Text(
    //                       TimeUtils.formatTimeDifference(story.createdAt),
    //                       style: context.bodySmall
    //                           .copyWith(fontSize: 12, color: Colors.grey),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               CachedNetworkImage(
    //                 key: key,
    //                 imageUrl: story.photoUrl,
    //                 fit: BoxFit.cover,
    //                 height: 300.h,
    //                 width: 400.w,
    //                 placeholder: (_, __) => const Center(
    //                   child: CupertinoActivityIndicator(),
    //                 ),
    //                 errorWidget: (_, __, ___) => const Icon(Icons.error),
    //                 cacheManager: CacheManager(
    //                   Config(
    //                     'story',
    //                     stalePeriod: const Duration(minutes: 5),
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 padding:
    //                     REdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //                 alignment: Alignment.center,
    //                 child: Text(
    //                   story.description,
    //                   maxLines: 4,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16).r,
      child: OpenContainer(
        openColor: Colours.backgroundColor,
        closedColor: Colours.backgroundColor,
        useRootNavigator: true,
        closedBuilder: (_, __) => Stack(
          children: [
            CachedNetworkImage(
              key: key,
              width: double.infinity,
              imageUrl: story.photoUrl,
              height: extent.h,
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
            Positioned(
              bottom: Sizes.p8,
              left: Sizes.p8,
              child: Text(
                'StoryName'.tr(namedArgs: {'name': story.name}),
                style:
                    context.labelSmall.copyWith(color: Colours.backgroundColor),
              ),
            ),
          ],
        ),
        openBuilder: (_, __) => DetailPage(story: story),
      ),
    );
  }
}
