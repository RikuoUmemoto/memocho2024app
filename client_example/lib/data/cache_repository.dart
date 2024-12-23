import '../model/human.dart';

class CacheRepository {
  Human? _cache;

  Human? getHuman() => _cache;

  void cache(Human human) {
    _cache = human;
  }
}
