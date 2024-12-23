void main() {
  List<int> a = [1, 5, 13, 2, 21, 30, 3, 8, 1, 33, 50, 89];
  List<int> b = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 89];
  List<int> result = {}; // (今回は同じ数字を許容していますが、Setだと勝手に重複排除してくれます)

  for (var i in a) {
    for (var j in b) {
      if (i == j) {
        result.add(i);
      }
    }
  }

  for (var i in a) {
    if (b.contains(i)) {
      result.add(i);
    }
  }

  final resultList = result.toList();
  resultList.sort();
  print(resultList);

  final resultList2 = Set.from(a).intersection(Set.from(b)).toList();
  resultList2.sort();
  print(resultList2);
}

