import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulari B',
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
  int _selectedStep = 0;
  final myController = TextEditingController();

  late final List<Widget> _pages = [
    _buildPersonalScreen(),
    _buildContactScreen(),
    _buildUploadScreen(),
  ];

  void _goToStep(int step) {
    setState(() {
      _selectedStep = step;
    });
  }

  Widget _buildPersonalScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        const Text(
          'PERSONAL', 
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text(
          'Pulsi "Contact" o pulsi el botó de "Continue"',
          style: TextStyle(fontSize: 18)
          ),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              _goToStep(1);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          child: Text('Continue'), 
          ),
          ElevatedButton(
            onPressed: () {
              _goToStep(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
            ),
          child: Text('Cancel'), 
          ),
        ]
        )
      ],
    );
  }

  Widget _buildContactScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        const Text(
          'CONTACT', 
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Text(
          'Pulsi "Upload" o pulsi el botó de "Continue"',
          style: TextStyle(fontSize: 18)
          ),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              _goToStep(2);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          child: Text('Continue'), 
          ),
          ElevatedButton(
            onPressed: () {
              _goToStep(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
            ),
          child: Text('Cancel'), 
          ),
        ]
        )
      ],
    );
  }

  Widget _buildUploadScreen() {
    final emailController = TextEditingController();
    final addressController = TextEditingController();
    final mobileController = TextEditingController();

    void _showDialogMessage() {  
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
              Text('Email: ${emailController.text}'),
              Text('Address: ${addressController.text}'),
              Text('Mobile: ${mobileController.text}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        const Text(
          'UPLOAD', 
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: TextField(
            controller: emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email, color: Colors.blue),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.lightBlue),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: TextField(
            controller: addressController,
            maxLines: 3,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.home, color: Colors.blue),
              hintText: 'Address',
              hintStyle: TextStyle(color: Colors.lightBlue),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue, width: 2),
          ),
          child: TextField(
            controller: mobileController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone_android, color: Colors.blue),
              hintText: 'Mobile No',
              hintStyle: TextStyle(color: Colors.lightBlue),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            keyboardType: TextInputType.phone,
          ),
        ),
        const SizedBox(height: 40),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _showDialogMessage,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        child: Text('Continue'), 
        ),
        ElevatedButton(
          onPressed: () {
            _goToStep(1);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
          ),
        child: Text('Cancel'), 
        ),
      ]
      )
    ],
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget currentContent = _pages[_selectedStep];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ivan Plaza 25/26',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      GestureDetector(
        onTap: () => _goToStep(0),
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: _selectedStep >= 0 ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 5),
            Text(
              'Personal',
              style: TextStyle(
                color: _selectedStep >= 0 ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () => _goToStep(1),
        child: Row(
          children: [
            Icon(
              Icons.edit_outlined,
              color: _selectedStep >= 1 ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 5),
            Text(
              'Contact',
              style: TextStyle(
                color: _selectedStep >= 1 ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () => _goToStep(2),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: _selectedStep >= 2 ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 5),
            Text(
              'Upload',
              style: TextStyle(
                color: _selectedStep >= 2 ? Colors.blue : Colors.grey,
              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: currentContent,
                ),
              )
              )
          ],
        ),
      ),
    );
  }
}