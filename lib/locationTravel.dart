import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class locationTravelPage extends StatefulWidget {
  @override
  _locationTravelPageState createState() => _locationTravelPageState();
}

class _locationTravelPageState extends State<locationTravelPage> {
  TextEditingController _placeCodeController = TextEditingController();
  TextEditingController _locationNameController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สถานที่ท่องเที่ยว'),
        backgroundColor: Color.fromARGB(255, 254, 123, 1),
      ),
      backgroundColor: const Color.fromARGB(255, 49, 83, 99),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTextField(_placeCodeController, 'Place Code'),
            _buildTextField(_locationNameController, 'Location Name'),
            _buildTextField(_detailsController, 'Details'),
            _buildTextField(_latitudeController, 'Latitude'),
            _buildTextField(_longitudeController, 'Longitude'),
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
    final placeCode = _placeCodeController.text;
    final locationName = _locationNameController.text;
    final details = _detailsController.text;
    final latitude = _latitudeController.text;
    final longitude = _longitudeController.text;

    final apiUrl = 'http://localhost/Api_tourlism/locationTravel.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'place_code': placeCode,
          'location_name': locationName,
          'details': details,
          'latitude': latitude,
          'longitude': longitude,
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
