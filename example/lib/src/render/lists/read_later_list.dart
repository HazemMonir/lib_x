import 'package:example/src/src.dart';

class ReadLaterListView extends StatelessWidget {
  const ReadLaterListView({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsList newsController = NewsListProvider.of(context).newsList;

    return ReBuilder(
      controller: newsController,
      builder: () {
        return ListView.builder(
          itemCount: newsController.readLaterList.length,
          itemBuilder: (context, index) {
            return StoryProvider(
              story: newsController.readLaterList[index],
              child: const StoryCard(),
            );
          },
        );
      },
    );
  }
}
