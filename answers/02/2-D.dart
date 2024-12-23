extension RestaurantExtension on Restaurant {
  double get rateAverage {
    double sum = 0;
    for(var rate in ratings) {
      sum += rate.rate;
    }
    return sum / ratings.length;

    // final total = ratings.fold(0, (prev, rate) => prev + rate.rate);
    // return total / numRatings;
  }
}

