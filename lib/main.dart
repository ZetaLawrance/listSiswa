import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form with Table',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'List Siswa'),
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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();

  List<Map<String, String>> students = [];

  void _addStudent() {
    setState(() {
      students.add({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'class': _classController.text,
        'major': _majorController.text,
      });
      _clearFields();
    });
  }

  void _clearFields() {
    _firstNameController.clear();
    _lastNameController.clear();
    _classController.clear();
    _majorController.clear();
  }

  void _editStudent(int index) {
    setState(() {
      _firstNameController.text = students[index]['firstName']!;
      _lastNameController.text = students[index]['lastName']!;
      _classController.text = students[index]['class']!;
      _majorController.text = students[index]['major']!;
      students.removeAt(index);
    });
  }

  void _deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(hintText: "First name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(hintText: "Last name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _classController,
                decoration: const InputDecoration(hintText: "Class"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _majorController,
                decoration: const InputDecoration(hintText: "Major"),
              ),
            ),
            ElevatedButton(
              onPressed: _addStudent,
              child: const Text('Kirim'),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                margin: const EdgeInsets.all(16.0),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.deepPurple.shade50),
                    dataRowColor: MaterialStateColor.resolveWith((states) => Colors.deepPurple.shade100.withOpacity(0.1)),
                    border: TableBorder.all(color: Colors.deepPurple.shade100, width: 1.0),
                    columns: const [
                      DataColumn(label: Text('First Name', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Last Name', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Class', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Major', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: List<DataRow>.generate(
                      students.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(Text(students[index]['firstName']!)),
                          DataCell(Text(students[index]['lastName']!)),
                          DataCell(Text(students[index]['class']!)),
                          DataCell(Text(students[index]['major']!)),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editStudent(index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteStudent(index),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
