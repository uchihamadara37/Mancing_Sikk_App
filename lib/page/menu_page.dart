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
    TeamMembersPage(),
    SumCalculatorPage(),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: "Kalkulator"),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_1), label: "Ganjil/Genap"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Anggota"),
          BottomNavigationBarItem(icon: Icon(Icons.summarize), label: "Total"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Untuk menampilkan semua item
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

// ======================= Halaman Anggota Kelompok =======================
class TeamMembersPage extends StatelessWidget {
  const TeamMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Anggota Kelompok:",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          MemberCard(
            name: "Ahmad Zakaria",
            nim: "123220077",
          ),
          SizedBox(height: 10),
          MemberCard(
            name: "Andrea Alfian",
            nim: "123220078",
          ),
          SizedBox(height: 10),
          MemberCard(
            name: "Panji Arif Jafarudin",
            nim: "123220089",
          ),
        ],
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final String name;
  final String nim;

  const MemberCard({
    required this.name,
    required this.nim,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(name[0]), // Menampilkan huruf pertama nama
        ),
        title: Text(name),
        subtitle: Text("NIM: $nim"),
      ),
    );
  }
}

// ======================= Jumlah Total Angka =======================
class SumCalculatorPage extends StatefulWidget {
  const SumCalculatorPage({super.key});

  @override
  State<SumCalculatorPage> createState() => _SumCalculatorPageState();
}

class _SumCalculatorPageState extends State<SumCalculatorPage> {
  final TextEditingController numberController = TextEditingController();
  String _result = "Total: 0 dan banyak angka : 0";
  String _sumSomeChar = "Angka 1 muncul sebanyak 0 kali";

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  void _calculateSum() {
    String input = numberController.text;
    int sum = 0;

    Map<String, int> digitCount = {};
    for (int i = 0; i < input.length; i++) {
      sum += int.tryParse(input[i]) ?? 0;
      digitCount[input[i]] = (digitCount[input[i]] ?? 0) + 1;
    }
    setState(() {
      _sumSomeChar = '';
      for (int i = 0; i <= 9; i++) {
        int count = digitCount['$i'] ?? 0;
        if (count > 0) {
          _sumSomeChar += "Angka $i muncul sebanyak $count kali\n";
        }
      }
    });

    setState(() {
      _result = "Total: $sum dan banyak angka : ${input.length}";
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
              labelText: "Masukkan Angka",
              border: OutlineInputBorder(),
              hintText: "Contoh: 12345",
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculateSum,
            child: Text("Hitung Total"),
          ),
          SizedBox(height: 20),
          Text(
            _sumSomeChar,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
