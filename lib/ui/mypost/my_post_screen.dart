import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'MyPostCard.dart';
import 'my_post_controller.dart';

class MyPostScreen extends StatelessWidget {
  final MyPostController controller = Get.put(MyPostController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // Ensure content is not obstructed by system UI
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16), // Added some padding for spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row with back button and logo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
            Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: Colors.red[900],
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
                padding: EdgeInsets.zero,
                iconSize: 18,
              ),
            )
            ),
                  // Your logo asset
                  Image.asset(
                    "assets/logo.png",
                    height: 65.h,
                    width: 61.w, // +10%
                    color: Colors.red[900],
                  ),
                ],
              ),

              // "My Post" text below the back button
              Padding(
                padding: const EdgeInsets.only(top: 0), // Space between the button and text
                child: const Text(
                  "My Post",
                  style: TextStyle(
                    fontSize: 14, // Larger font size for the title
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
SizedBox(height: 10,),
              // Body content (posts)
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.posts.isEmpty) {
                  return const Center(
                    child: Text(
                      "No posts yet",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true, // Ensure ListView doesn't take up excess space
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling on ListView
                  itemCount: controller.posts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final post = controller.posts[index];
                    return MyPostCard(
                      index: index,
                      post: post,
                      controller: controller,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
