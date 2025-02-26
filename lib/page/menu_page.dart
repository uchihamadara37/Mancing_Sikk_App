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
      appBar: AppBar(
        title: Text(
          "Menu Utama",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
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
        type: BottomNavigationBarType.fixed,
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
  String _result = "0";
  String _operator = "?";

  @override
  void initState() {
    super.initState();
    num1Controller.addListener(_updateResult);
    num2Controller.addListener(_updateResult);
  }

  @override
  void dispose() {
    num1Controller.dispose();
    num2Controller.dispose();
    super.dispose();
  }

  void _updateResult() {
    if (_operator != "?") {
      double num1 = double.tryParse(num1Controller.text) ?? 0;
      double num2 = double.tryParse(num2Controller.text) ?? 0;
      double result = _operator == "+" ? num1 + num2 : num1 - num2;
      setState(() {
        _result = "$result";
      });
    } else {
      setState(() {
        _result = "0";
      });
    }
  }

  void _calculate(bool isAddition) {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;
    double result = isAddition ? num1 + num2 : num1 - num2;

    setState(() {
      _operator = isAddition ? "+" : "-";
      _result = "$result";
    });
    _updateResult();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54, width: 1.0),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                _result,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: num1Controller,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Angka Pertama",
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  _operator,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: num2Controller,
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Angka Kedua",
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => _calculate(true),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  backgroundColor: Colors.green, // <-- Button color
                  foregroundColor: Colors.white, // <-- Splash color
                ),
                child: Text("+", style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(
                onPressed: () => _calculate(false),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(20),
                  backgroundColor: Colors.green, // <-- Button color
                  foregroundColor: Colors.white, // <-- Splash color
                ),
                child: Text("-", style: TextStyle(fontSize: 20)),
              ),
            ],
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
  String _maxVal = "";

  void _checkOddEven() {
    int? num = int.tryParse(numberController.text);
    setState(() {
      if (num != null) {
        _result = num % 2 == 0 ? "Ini Genap" : "Ini Ganjil";
      } else {
        _result = "Bukan Angka Semua";
      }
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
            maxLength: 20,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: "Masukkan Bilangan",
              border: OutlineInputBorder(),
              counterText: "",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            ),
            onChanged: (value) {
              if (value.length > 19) {
                setState(() {
                  _maxVal = "Udh bg jgn bnyk2";
                });
              } else if (value.isEmpty) {
                setState(() {
                  _maxVal = "";
                  _result = "Masukkan angka";
                });
              } else {
                _maxVal = "";
                _checkOddEven();
              }
            },
          ),
          SizedBox(height: 20),
          Text(_maxVal),
          SizedBox(height: 20),
          Text(
            _result,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
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
            "Anggota Kelompok",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
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
            nim: "123220091",
          ),
          SizedBox(height: 10),
          MemberCard(
            name: "Muhammad Islakha",
            nim: "123210096",
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
          backgroundColor: Colors.green,
          child: Text(
            name[0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
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
  String _sumSomeChar = "";

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
      if (int.tryParse(input[i]) != null) {
        sum += int.tryParse(input[i])!;
        digitCount[input[i]] = (digitCount[input[i]] ?? 0) + 1;
      }
    }
    setState(() {
      _sumSomeChar = '';
      for (int i = 0; i <= 9; i++) {
        int count = digitCount['$i'] ?? 0;
        if (count > 0) {
          _sumSomeChar += "Angka $i muncul sebanyak $count kali\n";
        }
      }
      _result =
          "Total: $sum dan banyak angka : ${input.replaceAll(RegExp(r'[^0-9]'), '').length}";
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
            maxLength: 20,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: "Masukkan Angka",
              border: OutlineInputBorder(),
              hintText: "Contoh: 12345",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            ),
            onChanged: (value) {
              _calculateSum();
            },
          ),
          SizedBox(height: 20),
          SizedBox(height: 20),
          Text(
            _sumSomeChar,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            _result,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
