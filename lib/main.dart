import 'package:flutter/material.dart';
import 'package:unit7_pizzalist/pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Pizza> pizzaInOrder = [];

  void initState(){
    super.initState();
    pizzaInOrder.add(Pizza("Pepperoni", 2));
    pizzaInOrder.add(Pizza("Pinneaple ", 3));

  }

  void _addPizza() {
    // TODO: display add pizza Dialog window
    TextEditingController _toppingController = TextEditingController();
    int tempSizeIndex = 0;
    showDialog<void>(


      context: context,
      // The inner content is self-contained and manages the Slider's state
      builder: (BuildContext dialogContext) {

        return AlertDialog(
          title: const Text('Build Your Pizza'),
          content: StatefulBuilder( // Use StatefulBuilder to manage the Slider's state
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  TextField(controller: _toppingController, ),
                  Slider(
                    value: tempSizeIndex.toDouble(),
                    min: 0,
                    max: (PIZZA_SIZES.length - 1).toDouble(),
                    divisions: PIZZA_SIZES.length - 1,
                    onChanged: (double newValue) {
                      setState(() { // This rebuilds only the AlertDialog's content
                        tempSizeIndex = newValue.round();
                      });
                    },
                  ),

                ]
              );
            },
          ),
          actions: [
            // put button widgets here
            ElevatedButton(
              onPressed:() {

                setState(() {
                  pizzaInOrder.add(Pizza(_toppingController.text, tempSizeIndex));
                });
                Navigator.pop(context);
              },
              child: Text('Add Pizza'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(itemCount:pizzaInOrder.length, itemBuilder: (BuildContext context, int index) {

        return Card(child: ListTile(
            title: Text(pizzaInOrder[index].description),
            subtitle: Text("Price: ${pizzaInOrder[index].price.toString()}")
        ));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPizza,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

