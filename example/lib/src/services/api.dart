import 'package:example/src/src.dart';

abstract class Api {
  static Future<List<NewsStory>> fetchStories() async {
    // load from db logic
    final List<NewsStory> results = [];
    // fake it till you make it
    final List<Map<String, dynamic>> snapshot = List.generate(
      10,
      (index) => {
        'id': genId(),
        'title': 'Title: $index',
        'content': 'Some content here',
      },
    );
    for (var value in snapshot) {
      results.add(NewsStory.fromMap(value));
    }
    return results;
  }
}
