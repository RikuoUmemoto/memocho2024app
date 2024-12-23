void main() {
  for (var i = 1; i <= 100; i++) {
    print('$i: ${helloWorld(i)}');
  }

  // final list = List<int>.generate(100, (i) => i + 1);
  // list
  //     .map((int e) => (e % 3 == 0 && e % 5 == 0)
  //         ? '$e: Hello World!'
  //         : e % 3 == 0
  //             ? '$e: Hello'
  //             : e % 5 == 0
  //                 ? '$e: World'
  //                 : '$e')
  //     .forEach(print);
}

String helloWorld(int i) {
  if (i % 3 == 0 && i % 5 == 0) {
    return 'Hello World!';
  } else if (i % 3 == 0) {
    return 'Hello';
  } else if (i % 5 == 0) {
    return 'World';
  } else {
    return '';
  }
}

