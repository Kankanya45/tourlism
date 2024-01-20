import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TramSchedulePage extends StatefulWidget {
  @override
  _TramSchedulePageState createState() => _TramSchedulePageState();
}

class _TramSchedulePageState extends State<TramSchedulePage> {
  TextEditingController _numberController = TextEditingController();
  TextEditingController _placeCodeController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตารางการเดินรถราง'),
        backgroundColor: Color.fromARGB(255, 254, 123, 1),
      ),
      backgroundColor: const Color.fromARGB(255, 49, 83, 99),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTextField(_numberController, 'Number'),
            SizedBox(height: 16.0),
            _buildTextField(_placeCodeController, 'Place Code'),
            SizedBox(height: 24.0),
            _buildTimePickerButton(),
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white, fontSize: 18.0),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }

  Widget _buildTimePickerButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            color: Colors.white,
            size: 24.0,
          ),
          SizedBox(width: 8.0),
          Text(
            _selectedTime != null
                ? 'Time: ${_selectedTime!.hour}:${_selectedTime!.minute}'
                : 'Select Time',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          TextButton(
            onPressed: () => _selectTime(context),
            child: Text(
              'เลือกเวลา',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              backgroundColor: Colors.transparent,
              side: BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveLocationData() async {
    final number = _numberController.text;
    final time = _selectedTime != null
        ? '${_selectedTime!.hour}:${_selectedTime!.minute}'
        : '';
    final placeCode = _placeCodeController.text;

    final apiUrl = 'http://localhost/Api_tourlism/TramSchedule.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'numbers': number,
          'time_s': time,
          'place_code': placeCode,
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
}
