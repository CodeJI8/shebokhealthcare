import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String baseUrl = "https://api.shebokhealthcare.com";

  Future<Map<String, dynamic>> userReg({
    required String name,
    required String phone,
    required String password,
    String? refer,
  }) async {
    final url = Uri.parse('$baseUrl/signup.php');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "phone": phone,
        "password": password,
        if (refer != null) "refered_by": refer,
      }),
    );

    print("📜 Raw Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to login. Code: ${response.statusCode}");
    }
  }



// 👉 User Login
  Future<Map<String, dynamic>> userLogin({
    required String phone,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login.php');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "password": password,
      }),
    );

    print("📜 Raw Login Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to login. Code: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> donorReg({
    required String bloodGroup,
    String? lastDonationDate,
    String? medicalInfo,
    double? latitude,
    double? longitude,
    String? district,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/donor_reg.php');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "blood_group": bloodGroup,
        if (lastDonationDate != null) "last_donation_date": lastDonationDate,
        if (medicalInfo != null) "medical_info": medicalInfo,
        if (latitude != null && longitude != null) ...{
          "latitude": latitude.toString(),
          "longitude": longitude.toString(),
        },
        if (district != null) "district": district,
      }),
    );

    print("📜 Raw Donor Registration Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to register donor. Code: ${response.statusCode}");
    }
  }


  // 👉 Post Blood Request
  Future<Map<String, dynamic>> requestBlood({
    required String title,
    required String disease,
    required String hospital,
    required String bloodGroup,
    required String date, // Format: YYYY-MM-DD
    required String patientName,
    double? latitude,
    double? longitude,
    String? district,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/request_blood.php');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "title": title,
        "disease": disease,
        "hospital": hospital,
        "blood_group": bloodGroup,
        "date": date,
        "pat_name": patientName,
        if (latitude != null && longitude != null) ...{
          "latitude": latitude.toString(),
          "longitude": longitude.toString(),
        },
        if (district != null) "district": district,
      }),
    );

    print("📜 Raw Blood Request Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to post blood request. Code: ${response.statusCode}");
    }
  }





  // 👉 Get Blood Requests
  Future<Map<String, dynamic>> getBloodRequests({
    int page = 1,
    int limit = 10,
    String? bloodGroup,
    double? latitude,
    double? longitude,
    required String token,
  }) async {
    final queryParams = {
      "page": page.toString(),
      "limit": limit.toString(),
      if (bloodGroup != null && bloodGroup.isNotEmpty)
        "blood_group": bloodGroup,
      if (latitude != null) "latitude": latitude.toString(),
      if (longitude != null) "longitude": longitude.toString(),
    };

    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/get_blood_requests.php",
      queryParams,
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📡 Get Blood Requests Response: ${response.body}");
    print("📡 token: ${token}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch requests. Code: ${response.statusCode}");
    }
  }





  // 👉 Foreign Treatment Registration
  Future<Map<String, dynamic>> foreignTreatment({
    required String email,
    required String disease,
    required int duration, // in months
    String? description,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/foreign_treatment.php');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "email": email,
        "disease": disease,
        "duration": duration,
        if (description != null) "description": description,
      }),
    );

    print("📜 Raw Foreign Treatment Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to register foreign treatment. Code: ${response.statusCode}");
    }
  }


// 👉 Find Doctors
  Future<Map<String, dynamic>> findDoctors({
    String? district,
    double? latitude,
    double? longitude,
    int page = 1,
    int limit = 10,
    required String token, required long, required lat,
  }) async {
    final queryParams = {
      "page": page.toString(),
      "limit": limit.toString(),
      if (district != null && district.isNotEmpty) "district": district,
      if (latitude != null) "latitude": latitude.toString(),
      if (longitude != null) "longitude": longitude.toString(),
    };

    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/find_doctors.php",
      queryParams,
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📡 Find Doctors Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch doctors. Code: ${response.statusCode}");
    }
  }





}
