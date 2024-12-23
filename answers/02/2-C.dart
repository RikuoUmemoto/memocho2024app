class Rate {
  const Rate({
    required this.rate,
  }) : assert(rate > 0 && rate <= 5);

  final double rate;
}

class Restaurant {
  const Restaurant({
    required this.name,
    required this.ratings,
  });

  final String name;
  final List<Rate> ratings;

  int get numRatings => ratings.length;
}

Future<void> main() async {
  final restaurant = Restaurant(
    name: 'サイゼリヤ',
    ratings: [
      Rate(rate: 1),
      Rate(rate: 2),
      Rate(rate: 5),
    ],
  );

  print(restaurant.numRatings);
}


