import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_poc/counter_model.dart';
import 'package:flavor_poc/database/firebase.dart';
import 'package:flavor_poc/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late Counter fetchedCounter;

  final CounterRepository counterRepository = CounterRepository();

  @override
  void initState() {
    super.initState();
    _fetchCounter();
  }

  Future<void> _fetchCounter() async {
    fetchedCounter = await counterRepository.fetchCounter();
    setState(() {
      _counter = fetchedCounter.value;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      // Update counter value in Firestore when the counter is incremented
      counterRepository
          .updateCounter(Counter(id: fetchedCounter.id, value: _counter));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Flavors"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bouton appuyé tant de fois sur dev:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
