import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(top: 80, bottom: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                Text(
                  "Mancing\nSikk!",
                  style: TextStyle(
                    fontSize: 35,
                    height: 1.2,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    height: 4,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10))),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Aplikasi untuk lulusan Sarjana\nyang masih gabut di rumah.",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 110,
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF034D40),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  )),
                              minimumSize: Size(0, 38)),
                          label: Text(
                            "Let's Go!",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          
                          
                        )
                      )
                    )
              ],
            ),
          )),
    );
  }
}
