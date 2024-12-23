import 'dart:math';

class Restaurant implements Reserve {
  const Restaurant({
    required this.name,
    required this.ratings,
  });

  final String name;
  final List<Rate> ratings;

  int get numRatings => ratings.length;

  @override
  Future<bool> reserve() async {
    await Future<void>.delayed(Duration(seconds: 1));
    return Random().nextBool();
  }
}

interface class Reserve {
  Future<bool> reserve();
}

