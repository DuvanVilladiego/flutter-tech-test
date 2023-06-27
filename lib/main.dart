import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Login!'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FormExample(),
      ),
    );
  }
}

class FormExample extends StatefulWidget {
  const FormExample({Key? key}) : super(key: key);

  @override
  State<FormExample> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = '';
  String _lastname = '';
  DateTime _bornDate = DateTime.now();
  List<String> _address = <String>[];

  // Map<String, dynamic> _input = {
  //   'name': '',
  //   'lastname': '',
  //   'borndate': '',
  //   'address': <String>[],
  //   'principaladdress': 0,
  // };

  void setName(String value) {
    setState(() {
      _name = value;
    });
  }

  void setLastname(String value) {
    setState(() {
      _lastname = value;
    });
  }

  void setAddress(String value) {
    setState(() {
      _address.add(value);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _bornDate) {
      setState(() {
        _bornDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setName(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Lastname',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your lastname';
                  }
                  return null;
                },
                onSaved: (value) {
                  setLastname(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  setAddress(value!);
                },
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Born Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _bornDate != null
                            ? '${_bornDate!.toLocal()}'.split(' ')[0]
                            : 'Select a date',
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print('Name: $_name');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}