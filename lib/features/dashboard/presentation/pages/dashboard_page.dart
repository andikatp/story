import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
            return GridView.builder(
              itemBuilder: (context, index) =>
                  Tile(story: state.stories[index]),
              itemCount: state.stories.length,
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  const QuiltedGridTile(2, 2),
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 2),
                ],
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
    return SizedBox(
      height: 200,
      child: Image.network(story.photoUrl),
    );
  }
}
