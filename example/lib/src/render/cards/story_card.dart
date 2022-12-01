import 'package:example/src/src.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsStory story = StoryProvider.of(context).story;
    return Column(
      children: [
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => X.to(path: storyPath(story.id)),
          child: Text(story.title),
        ),
        ReBuilder(
          controller: story,
          builder: () {
            final bool added = story.readLater;
            return TextButton(
              onPressed: () => story.toggleReadLater(),
              child:
                  Text(added ? 'Remove from read later' : 'Add to read later'),
            );
          },
        ),
      ],
    );
  }
}
