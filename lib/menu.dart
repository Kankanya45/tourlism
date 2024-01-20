import 'package:flutter/material.dart';
import 'package:tourlism_root_641463010/StoreType.dart';
import 'package:tourlism_root_641463010/StoreName.dart';
import 'package:tourlism_root_641463010/TramSchedule.dart';
import 'package:tourlism_root_641463010/locationTravel.dart';

class MyMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Color.fromARGB(255, 254, 123, 1),
      ),
      backgroundColor: const Color.fromARGB(255, 49, 83, 99),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyMenuButton(
                    label: 'สถานที่ท่องเที่ยว',
                    iconPath: 'images/locationTravel.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => locationTravelPage(),
                        ),
                      );
                    },
                  ),
                  MyMenuButton(
                    label: 'ชื่อร้านค้า',
                    iconPath: 'images/StoreName.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreNamePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Second Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyMenuButton(
                    label: 'ประเภทร้านค้า',
                    iconPath: 'images/StoreType.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreTypePage(),
                        ),
                      );
                    },
                  ),
                  MyMenuButton(
                    label: 'ตารางการเดินรถราง',
                    iconPath: 'images/TramSchedule.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TramSchedulePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyMenuButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onTap;

  MyMenuButton({
    required this.label,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Container(
        width: 250, // กำหนดความกว้างของ Container เป็น 250
        height: 250, // กำหนดความสูงของ Container เป็น 250
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(211, 255, 153, 0),
              Color.fromARGB(183, 247, 245, 113)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 150, // กำหนดความกว้างของรูปภาพเป็น 150
              height: 150, // กำหนดความสูงของรูปภาพเป็น 150
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
