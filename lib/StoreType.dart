import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StoreTypePage extends StatefulWidget {
  @override
  _StoreTypePageState createState() => _StoreTypePageState();
}

class _StoreTypePageState extends State<StoreTypePage> {
  TextEditingController _idTypeController = TextEditingController();
  TextEditingController _nameTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประเภทของร้านค้า'),
        backgroundColor: Color.fromARGB(255, 254, 123, 1),
      ),
      backgroundColor: const Color.fromARGB(255, 49, 83, 99),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTextField(_idTypeController, 'ID Type'),
            _buildTextField(_nameTypeController, 'Name Type'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await _saveLocationData();
                Navigator.pop(context);
              },
              child: Text('บันทึกข้อมูล'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 50),
                primary: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String labelText,
  ) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.white),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveLocationData() async {
    final idType = _idTypeController.text;
    final nameType = _nameTypeController.text;

    final apiUrl = 'http://localhost/Api_tourlism/StoreType.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'id_type': idType,
          'name_type': nameType,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location data saved successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save location data')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while saving location data')),
      );
    }
  }
}
