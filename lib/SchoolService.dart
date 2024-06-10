import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SchoolService {
  Future<void> approveSchool(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('Token');
    String url = 'http://10.0.2.2:8000/api/approveSchool/$id';
    try {
      final response = await http.put(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        // Handle successful approval
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> rejectSchools(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('Token');
    String url = 'http://10.0.2.2:8000/api/unapproveSchool/$id';
    try {
      final response = await http.put(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        // Handle successful rejection
      }
    } catch (e) {
      print(e);
    }
  }

}
