import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CalculatorPage(),
    OddEvenPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu Utama"), backgroundColor: Colors.green),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Kalkulator"),
          BottomNavigationBarItem(icon: Icon(Icons.filter_1), label: "Ganjil/Genap"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}

// ======================= Kalkulator Penjumlahan & Pengurangan =======================
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  String _result = "Hasil: ";

  void _calculate(bool isAddition) {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;
    double result = isAddition ? num1 + num2 : num1 - num2;

    setState(() {
      _result = "Hasil: $result";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: num1Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Angka Pertama",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: num2Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Angka Kedua",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _calculate(true),
                child: Text("Tambah"),
              ),
              ElevatedButton(
                onPressed: () => _calculate(false),
                child: Text("Kurang"),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            _result,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// ======================= Cek Ganjil atau Genap =======================
class OddEvenPage extends StatefulWidget {
  const OddEvenPage({super.key});

  @override
  State<OddEvenPage> createState() => _OddEvenPageState();
}

class _OddEvenPageState extends State<OddEvenPage> {
  final TextEditingController numberController = TextEditingController();
  String _result = "Masukkan angka";

  void _checkOddEven() {
    int num = int.tryParse(numberController.text) ?? 0;
    setState(() {
      _result = num % 2 == 0 ? "Ini Genap" : "Ini Ganjil";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: numberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Masukkan Bilangan",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _checkOddEven,
            child: Text("Cek Ganjil/Genap"),
          ),
          SizedBox(height: 20),
          Text(
            _result,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
