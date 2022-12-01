import 'package:example/src/src.dart';

class StoriesListView extends StatelessWidget {
  const StoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsList newsController = NewsListProvider.of(context).newsList;

    return ReBuilder(
      controller: newsController,
      builder: () {
        return ListView.builder(
          itemCount: newsController.newsList.length,
          itemBuilder: (context, index) {
            return StoryProvider(
              story: newsController.newsList[index],
              child: const StoryCard(),
            );
          },
        );
      },
    );
  }
}
