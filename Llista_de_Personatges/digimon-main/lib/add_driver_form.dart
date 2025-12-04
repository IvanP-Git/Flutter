import 'package:flutter/material.dart';
import 'driver_model.dart';

class AddDriverFormPage extends StatefulWidget {
  const AddDriverFormPage({super.key});

  @override
  _AddDriverFormPageState createState() => _AddDriverFormPageState();
}

class _AddDriverFormPageState extends State<AddDriverFormPage> {
  final nameController = TextEditingController();
  final teamController = TextEditingController();
  final numberController = TextEditingController();

  void submit() {
    final name = nameController.text.trim();
    final teamId = teamController.text.trim();
    final numberText = numberController.text.trim();

    if (name.isEmpty || teamId.isEmpty || numberText.isEmpty) 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fill all fields')),
      );
      return;
    }

    int? num = int.tryParse(numberText);

    if (num == null) 
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Number must be numeric')),
      );
      return;
    }

    final id = name.toLowerCase().replaceAll(' ', '_');

    final driver = Driver(name: name, id: id)
      ..teamId = teamId
      ..number = num;

    Navigator.of(context).pop(driver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Driver')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full name'),
            ),
            TextField(
              controller: teamController,
              decoration: const InputDecoration(labelText: 'Team'),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: submit, child: const Text('Add Driver')),
          ],
        ),
      ),
    );
  }
}