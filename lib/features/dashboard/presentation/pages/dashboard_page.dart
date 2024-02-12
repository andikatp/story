import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:story/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:story/features/dashboard/presentation/widgets/tile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late ScrollController _scrollController;
  int _currentPage = 1;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMore)
      ..dispose();
    super.dispose();
  }

  void _loadMore() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll) {
      setState(() => _currentPage++);
      context
          .read<DashboardBloc>()
          .add(DashboardGetStories(page: _currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          switch (state.status) {
            case StoryStatus.loading:
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            case StoryStatus.error:
              return Center(
                child: Text(state.errorMessage),
              );
            case StoryStatus.success:
              final stories = state.stories;
              return MasonryGridView.count(
                controller: _scrollController,
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                itemCount: state.stories.length,
                itemBuilder: (context, index) {
                  return Tile(
                    extent: (index % 5 + 1) * 100,
                    story: stories[index],
                  );
                },
              );
            // return GridView.custom(
            //   controller: _scrollController,
            //   padding: REdgeInsets.all(8),
            //   gridDelegate: SliverQuiltedGridDelegate(
            //     crossAxisCount: 4,
            //     mainAxisSpacing: 8,
            //     crossAxisSpacing: 8,
            //     repeatPattern: QuiltedGridRepeatPattern.inverted,
            //     pattern: [
            //       const QuiltedGridTile(2, 2),
            //       const QuiltedGridTile(1, 1),
            //       const QuiltedGridTile(1, 1),
            //       const QuiltedGridTile(1, 2),
            //     ],
            //   ),
            //   childrenDelegate: SliverChildBuilderDelegate(
            //     childCount: state.stories.length,
            //     (context, index) => Tile(story: state.stories[index]),
            //   ),
            // );
          }
        },
      ),
    );
  }
}
