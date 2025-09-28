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
    int limit = 5,
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

// 👉 Join Thalassemia Club
  Future<Map<String, dynamic>> joinThalassemiaClub({
    String? bloodReportPath,     // optional CBC report image
    String? prescriptionPath,    // optional prescription image
    required int showNumber,     // 0 or 1
    required String bloodGroup,  // e.g. O+
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/join_thalasamia.php');

    // Using multipart request for file upload
    var request = http.MultipartRequest("POST", url);
    request.headers["Authorization"] = "Bearer $token";

    // Add fields
    request.fields["show_number"] = showNumber.toString();
    request.fields["blood_group"] = bloodGroup;

    // Add optional files
    if (bloodReportPath != null) {
      request.files.add(await http.MultipartFile.fromPath("blood_report_path", bloodReportPath));
    }
    if (prescriptionPath != null) {
      request.files.add(await http.MultipartFile.fromPath("prescription_path", prescriptionPath));
    }

    // Send request
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print("📜 Raw Join Thalassemia Club Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to join thalassemia club. Code: ${response.statusCode}");
    }
  }


  // 👉 Get Thalassemia Patients
  Future<Map<String, dynamic>> getThalassemiaPatients({
    int page = 1,
    int limit = 10,
    required String token,
  }) async {
    final queryParams = {
      "page": page.toString(),
      "limit": limit.toString(),
    };

    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/thalasamia_club.php",
      queryParams,
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📡 Get Thalassemia Patients Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch thalassemia patients. Code: ${response.statusCode}");
    }
  }



  // 👉 Get Sliders
  Future<Map<String, dynamic>> getSliders({
    required String token,
  }) async {
    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/get_all_sliders.php",
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📡 Get Sliders Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch sliders. Code: ${response.statusCode}");
    }
  }


  // 👉 Get My Posts
  Future<Map<String, dynamic>> getMyPosts({
    required String token,
  }) async {
    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/get_my_posts.php",
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📡 Get My Posts Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch posts. Code: ${response.statusCode}");
    }
  }



  // 👉 Search Users
  Future<Map<String, dynamic>> searchUsers({
    required String keyword,
    required String token,
  }) async {
    final queryParams = {
      "keyword": keyword,
    };

    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/search_users.php",
      queryParams,
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📡 Search Users Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to search users. Code: ${response.statusCode}");
    }
  }



  // 👉 Add Donors to Posts
  Future<Map<String, dynamic>> addDonorsToPosts({
    required String userId,
    required String requestId,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/add_donors_to_posts.php');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "user_id": userId,
        "request_id": requestId,
      }),
    );

    print("📜 Raw Add Donors to Posts Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to add donor. Code: ${response.statusCode}");
    }
  }






  // 👉 Get Donation History
  Future<Map<String, dynamic>> getDonationHistory({
    required String token,
  }) async {
    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/donation_history.php",
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📡 Get Donation History Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch donation history. Code: ${response.statusCode}");
    }
  }




  // 👉 Get Profile
  Future<Map<String, dynamic>> getProfile({
    required String token,
  }) async {
    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/get_profile.php",
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📡 Get Profile Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Failed to fetch create_profile. Code: ${response.statusCode}",
      );
    }
  }

  // 👉 Upload Profile
  Future<Map<String, dynamic>> uploadProfile({
    required String filePath,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/upload_profile.php');

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath(
      'profile_image',
      filePath,
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("📡 Upload Profile Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Failed to upload profile. Code: ${response.statusCode}",
      );
    }
  }



  // 👉 Upload KYC Verification File
  Future<Map<String, dynamic>> uploadKyc({
    required String filePath,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/upload_kyc.php');

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';

    // File field is "image" (as per docs)
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      filePath,
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("📡 Upload KYC Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Failed to upload KYC file. Code: ${response.statusCode}",
      );
    }
  }


  // 👉 Get Online Doctors
  Future<Map<String, dynamic>> getOnlineDoctors({
    String? specialization,
    int page = 1,
    int limit = 10,
    required String token,
  }) async {
    final queryParams = {
      "page": page.toString(),
      "limit": limit.toString(),
      if (specialization != null && specialization.isNotEmpty)
        "specialization": specialization,
    };

    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/get_doctors.php",
      queryParams,
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📡 Get Online Doctors Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          "Failed to fetch online doctors. Code: ${response.statusCode}");
    }
  }


  // inside Api.dart
  Future<Map<String, dynamic>> getAvailableSlots({
    required int doctorId,
    required String date, // Format: YYYY-MM-DD
    required String token,
  }) async {
    final queryParams = {
      "doctor_id": doctorId.toString(),
      "date": date,
    };

    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/get_available_slots.php",
      queryParams,
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📅 Get Available Slots Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Failed to fetch available slots. Code: ${response.statusCode}",
      );
    }
  }


  // inside Api.dart
  Future<Map<String, dynamic>> bookAppointment({
    required int slotId,
    required String date, // YYYY-MM-DD
    required String name,
    required double age,
    String? notes,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/book_appointment.php');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "slot_id": slotId,
        "date": date,
        "name": name,
        "age": age,
        if (notes != null && notes.isNotEmpty) "notes": notes,
      }),
    );

    print("📅 Book Appointment Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          "Failed to book appointment. Code: ${response.statusCode}");
    }
  }


  // 👉 Get User Appointments
  Future<Map<String, dynamic>> getUserAppointments({
    required String token,
  }) async {
    final uri = Uri.https(
      "api.shebokhealthcare.com",
      "/get_user_appointments.php",
    );

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print("📡 Get User Appointments Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        "Failed to fetch appointments. Code: ${response.statusCode}",
      );
    }
  }



}
