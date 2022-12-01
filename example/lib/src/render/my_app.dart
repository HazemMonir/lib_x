import 'package:example/src/src.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsList news = NewsList()..loadNewsStories();
    // App level providers
    return NewsListProvider(
      newsList: news,
      child: MaterialX(
        materialApp: materialApp,
        routeMap: routeMap,
      ),
    );
  }
}
