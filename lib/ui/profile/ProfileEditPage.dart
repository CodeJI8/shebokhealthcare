import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'ProfileController.dart';

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage({super.key});

  final ProfileController controller = Get.put(ProfileController());
  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.uploadProfileImage(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            controller.profileImage.value.isNotEmpty
                ? CircleAvatar(
              radius: 60,
              backgroundImage: FileImage(
                File(controller.profileImage.value),
              ),
            )
                : const CircleAvatar(
              radius: 60,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: _pickImage,
              child: const Text(
                "Upload Profile Image",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
