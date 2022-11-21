import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreference/screen.dart';

late SharedPreferences sharedPreferences;
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: homes(),
    );
  }
}

class homes extends StatefulWidget {
  homes({Key? key}) : super(key: key);

  @override
  State<homes> createState() => _homesState();
}

class _homesState extends State<homes> {
  @override
  void dispose() {
    super.dispose();
    textcontroler.dispose();
  }

  final textcontroler = TextEditingController();
  String? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              TextFormField(
                controller: textcontroler,
              ),
              ElevatedButton(
                onPressed: saveData,
                child: const Text(
                  'save value',
                ),
              ),
              const SizedBox(height: 20),
              (data == null) ? const Text("No data") : Text(data!),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('savedvalue', textcontroler.text);
    setState(() {
      data = sharedPreferences.getString('savedvalue');
    });
  }
}
