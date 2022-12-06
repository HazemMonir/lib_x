import 'package:example/src/src.dart';

class NewsListProvider extends DataProvider<NewsList> {
  final NewsList newsList;

  const NewsListProvider({
    super.key,
    required this.newsList,
    required super.child,
  }) : super(data: newsList);

  static NewsListProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NewsListProvider>()!;
}

class NewsList extends StatefulData {
  final List<NewsStory> newsList = [];
  final List<NewsStory> readLaterList = [];

  static late TabController tabController;

  void loadNewsStories() async {
    final List<NewsStory> stories = await Api.fetchStories();
    newsList.addAll(stories);
    update();
  }

  void loadReadLater() async {
    readLaterList.clear();
    final List<NewsStory> stories = await Future.value(
      newsList.where((story) => story.readLater).toList(),
    );
    readLaterList.addAll(stories);
    update();
  }

  NewsStory getById(String id) =>
      newsList.singleWhere((story) => story.id == id);
}
