import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final textController = TextEditingController();
  String result = '';

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void onButtonPressed() {
    try {
      List<int> numbers =
          textController.text.split(',').map(int.parse).toList();
      int outlier = findOutlier(numbers);
      if (outlier != -1) {
        setState(() {
          result = 'Liczba odstająca to $outlier';
        });
      } else {
        setState(() {
          result = 'Nie znaleziono liczby odstającej';
        });
      }
    } on FormatException catch (_) {
      setState(() {
        result = 'Podane liczby zostały wpisane niepoprawnie';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wyszukiwanie liczby odstającej',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wyszukiwanie liczby odstającej '),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    hintText: 'Wpisz liczby oddzielone przecinkiem'),
                controller: textController,
              ),
              ElevatedButton(
                onPressed: onButtonPressed,
                child: const Text('Wyszukaj'),
              ),
              const SizedBox(height: 20),
              Text(
                result,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int findOutlier(List<int> numbers) {
  int evenCount = 0;
  int oddCount = 0;
  int even = 0;
  int odd = 0;

  for (int number in numbers) {
    if (number % 2 == 0) {
      evenCount++;
      even = number;
    } else {
      oddCount++;
      odd = number;
    }
    if (evenCount > 1 && oddCount == 1) {
      return odd;
    } else if (oddCount > 1 && evenCount == 1) {
      return even;
    }
  }
  return -1;
}
