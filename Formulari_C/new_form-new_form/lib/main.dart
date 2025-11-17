import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulari C',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  String? selectedChip;
  bool isSwitched = false;
  String? selectedCountry;
  String? selectedRadio;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ivan Plaza 25/26',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  const Text( 
                    'Choice Chips', 
                    style: TextStyle( 
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                    ), 
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: [
                      ChoiceChip(
                        avatar: const Icon(Icons.flutter_dash, color: Colors.blue),
                        label: const Text('Flutter'),
                        selected: selectedChip == 'Flutter',
                        selectedColor: Colors.blue,
                        labelStyle: TextStyle(
                          color: selectedChip == 'Flutter'
                              ? Colors.white
                              : Colors.black,
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            selectedChip = selected ? 'Flutter' : null;
                          });
                        },
                      ),
                      ChoiceChip(
                        avatar: const Icon(Icons.android, color: Colors.green),
                        label: const Text('Android'),
                        selected: selectedChip == 'Android',
                        selectedColor: Colors.blue,
                        labelStyle: TextStyle(
                          color: selectedChip == 'Android'
                              ? Colors.white
                              : Colors.black,
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            selectedChip = selected ? 'Android' : null;
                          });
                        },
                      ),
                      ChoiceChip(
                        avatar: const Icon(Icons.laptop_chromebook, color: Colors.orange),
                        label: const Text('Chrome OS'),
                        selected: selectedChip == 'Chrome OS',
                        selectedColor: Colors.blue,
                        labelStyle: TextStyle(
                          color: selectedChip == 'Chrome OS'
                              ? Colors.white
                              : Colors.black,
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            selectedChip = selected ? 'Chrome OS' : null;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Switch',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: const Text(
                          'This is a switch',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    Switch(
                      value: isSwitched,
                      activeThumbColor: Colors.white,
                      activeTrackColor: Colors.blue,
                      onChanged: (bool value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text( 
                    'Text Field', 
                    style: TextStyle( 
                      fontSize: 16, 
                      fontWeight: FontWeight.bold, 
                    ), 
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: myController,
                    decoration: InputDecoration(
                      hintText: 'Escribe algo...',
                      counterText: '${myController.text.length}/15',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  if (myController.text.isEmpty || myController.text.length > 15)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        myController.text.isEmpty
                          ? '⚠️ El texto no puede estar vacío'
                          : '⚠️ No puede tener más de 15 caracteres',
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '✔️ Texto válido',
                        style: const TextStyle(color: Colors.green, fontSize: 14),
                      ),
                    ),
                  ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dropdown Field',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderDropdown<String>(
                        name: 'country',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Finland',
                            child: Text('Finland'),
                          ),
                          DropdownMenuItem(
                            value: 'Spain',
                            child: Text('Spain'),
                          ),
                          DropdownMenuItem(
                            value: 'United Kingdom',
                            child: Text('United Kingdom'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Radio Group Model',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          for (var option in ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4'])
                          RadioMenuButton<String>(
                            value: option,
                            groupValue: selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                selectedRadio = value;
                              });
                            },
                            child: Text(option),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
                floatingActionButton: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 20),
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.check_circle, color: Colors.green, size: 48),
                                SizedBox(height: 10),
                                Text(
                                  'Submission Completed',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text('Choice Chip: ${selectedChip ?? "Ninguno"}'),
                                Text('Switch: ${isSwitched ? "Encendido" : "Apagado"}'),
                                Text('Texto: ${myController.text.isNotEmpty ? myController.text : "Vacío"}'),
                                Text('Dropdown: ${selectedCountry ?? "Ninguno"}'),
                                Text('Radio Group: ${selectedRadio ?? "Ninguno"}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.upload_rounded, color: Colors.white, size: 28),
                  ),
                ),
                ),
      );
    }
  }