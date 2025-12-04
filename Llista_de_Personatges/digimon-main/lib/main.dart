import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'driver_model.dart';
import 'driver_list.dart';
import 'add_driver_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F1 Drivers App',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(title: 'F1 Drivers - Ivan Plaza 25/26'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Driver> drivers = [];
  double ratingFilter = 0.0;

  @override
  void initState() {
    super.initState();
    loadDriversFromApi();
  }

  Future<void> loadDriversFromApi() async {
    HttpClient http = HttpClient();
    var uri = Uri.parse("https://f1api.dev/api/current/drivers");
    var request = await http.getUrl(uri);
    var response = await request.close();
    var body = await response.transform(utf8.decoder).join();

    Map<String, dynamic> jsonData = jsonDecode(body);
    List apiDrivers = jsonData["drivers"];

    List<Driver> loadedDrivers = apiDrivers.map<Driver>((d) {
      final fullName = "${d["name"]} ${d["surname"]}";
      return Driver(name: fullName, id: d["driverId"].toString())
        ..teamId = d["teamId"]
        ..number = d["number"];
      }).toList();

      setState(() {
        drivers = loadedDrivers;
      });
  }

  List<Driver> get filteredDrivers {
    
    if (ratingFilter == 0) 
    {
      return drivers;
    }

    return drivers.where((d) => d.rating >= ratingFilter).toList();
  }

  Future<void> _showAddDriverForm() async {
    final Driver? newDriver = await Navigator.of(context).push<Driver>(
      MaterialPageRoute(builder: (_) => const AddDriverFormPage()),
    );

    if (newDriver != null) 
    {
      setState(() {
        drivers.add(newDriver);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          PopupMenuButton<double>(
            icon: const Icon(Icons.filter_alt),
            onSelected: (value) {
              setState(() => ratingFilter = value);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 0, child: Text("Show all")),
              PopupMenuItem(value: 5.0, child: Text("Rating ≥ 5")),
              PopupMenuItem(value: 7.0, child: Text("Rating ≥ 7")),
              PopupMenuItem(value: 9.0, child: Text("Rating ≥ 9")),
            ],
          ),
        ],
      ),
      body: DriverList(filteredDrivers),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDriverForm,
        label: const Text('Add Driver'),
        icon: const Icon(Icons.person_add),
      ),
    );
  }
}