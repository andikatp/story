import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/utils/time_utils.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';
import 'package:story/features/dashboard/presentation/bloc/dashboard_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is DashboardError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is DashboardLoaded) {
            final stories = state.stories..shuffle();
            return GridView.custom(
              padding: REdgeInsets.all(8),
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  const QuiltedGridTile(2, 2),
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: stories.length,
                (context, index) => Tile(story: stories[index]),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({required this.story, super.key});

  final StoryEntity story;

  @override
  Widget build(BuildContext context) {
    Future<dynamic> showDetail() {
      return showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60.h,
                    padding: REdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      spacing: 4,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          story.name,
                          style: context.bodyMedium,
                        ),
                        const Icon(Icons.circle, size: 4),
                        Text(
                          TimeUtils.formatTimeDifference(story.createdAt),
                          style: context.bodySmall
                              .copyWith(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  CachedNetworkImage(
                    key: key,
                    imageUrl: story.photoUrl,
                    fit: BoxFit.cover,
                    height: 300.h,
                    width: 400.w,
                    placeholder: (_, __) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: (_, __, ___) => const Icon(Icons.error),
                  ),
                  Container(
                    padding:
                        REdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    alignment: Alignment.center,
                    child: Text(story.description),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16).r,
      child: GestureDetector(
        onTap: showDetail,
        child: CachedNetworkImage(
          key: key,
          imageUrl: story.photoUrl,
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
      ),
    );
  }
}
