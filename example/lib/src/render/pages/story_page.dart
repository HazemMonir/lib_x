import 'package:example/src/src.dart';

class StoryPage extends StatelessWidget {
  final String id;
  const StoryPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final NewsList newsController = NewsListProvider.of(context).newsList;
    final NewsStory story = newsController.getById(id);

    return StoryProvider(
      story: story,
      child: ScaffoldX(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            StoryTitle(),
            StoryContent(),
          ],
        ),
      ),
    );
  }
}

class StoryTitle extends StatelessWidget {
  const StoryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsStory story = StoryProvider.of(context).story;
    return Text(story.title);
  }
}

class StoryContent extends StatelessWidget {
  const StoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsStory story = StoryProvider.of(context).story;
    return Text(story.content);
  }
}
