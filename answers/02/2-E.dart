Stream<String> asyncFizzBuzz() async* {
  for (var i = 1; i <= 30; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    if (i % 3 == 0 && i % 5 == 0) {
      yield 'fizz buzz';
    } else if (i % 3 == 0) {
      yield 'fizz';
    } else if (i % 5 == 0) {
      yield 'buzz';
    } else {
      yield '$i';
    }
  }
}

Future<void> main() async {
  final stream = asyncFizzBuzz();
  await for (final value in stream) {
    print(value);
  }
}

