import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'my_post_controller.dart';

Future<void> showDonorPopup(
    BuildContext context, int postIndex, MyPostController controller) async {
  final TextEditingController searchController = TextEditingController();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Title + Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Donated Person's Info",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Clear the previous search results when closing the dialog
                    controller.searchResults.clear();
                    searchController.clear();
                    Get.back();
                  },
                  child: const Icon(Icons.close, size: 22),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Searchable TextField with search icon
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Enter The Name",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.red[900]),
                  onPressed: () async {
                    final keyword = searchController.text.trim();
                    if (keyword.isEmpty) {
                      Get.snackbar("Error", "Please enter a name first");
                      return;
                    }

                    try {
                      final results =
                      await controller.searchUsers(keyword, token!);

                      if (results.isNotEmpty) {
                        controller.selectedUser.value = results.first;
                        Get.snackbar("Found",
                            "Selected donor: ${results.first["name"]}");
                      } else {
                        Get.snackbar("No Results",
                            "No donor found for '$keyword'");
                      }
                    } catch (e) {
                      Get.snackbar("Error", "Failed to search users: $e");
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 1.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red[900]!, width: 1.5),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              onChanged: (value) async {
                final keyword = value.trim();
                if (keyword.isNotEmpty) {
                  // Trigger search as user types
                  final results = await controller.searchUsers(keyword, token!);
                  controller.searchResults.value = results;
                } else {
                  controller.searchResults.clear();
                }
              },
            ),
            const SizedBox(height: 20),

            // 🔹 Display List of Donors Matching the Search Query
            Obx(() {
              if (controller.searchResults.isEmpty) {
                return const SizedBox.shrink();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final user = controller.searchResults[index];
                  return ListTile(
                    title: Text(user["name"] ?? "Unknown"),
                    subtitle: Text(user["phone"] ?? "N/A"),
                    onTap: () {
                      // Select a donor when clicked and update the TextField
                      controller.selectedUser.value = user;
                      searchController.text = user["name"] ?? "";
                      Get.snackbar("Selected", "Selected donor: ${user['name']}");
                    },
                  );
                },
              );
            }),

            const SizedBox(height: 20),

            // 🔹 Next Button
            Obx(() {
              return SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: controller.isAddingDonor.value
                      ? null
                      : () async {
                    if (token == null) {
                      Get.snackbar("Error", "You must login first");
                      return;
                    }

                    final success = await controller.addDonorToPost(
                      postIndex: postIndex,
                      token: token,
                    );

                    // 👇 close popup only if API success
                    if (success && Get.isDialogOpen == true) {
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: controller.isAddingDonor.value
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
