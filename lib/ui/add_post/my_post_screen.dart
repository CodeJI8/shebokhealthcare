import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'MyPostCard.dart';
import 'my_post_controller.dart';


class MyPostScreen extends StatelessWidget {
  // keep controller alive with permanent:true
  final MyPostController controller =
  Get.put(MyPostController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Post"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red[900]),
          onPressed: () => Get.back(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.bloodtype, color: Colors.red[900]),
          )
        ],
      ),
      body: Obx(() {
        if (controller.posts.isEmpty) {
          return const Center(
            child: Text(
              "No posts yet",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.posts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            // ✅ Use the separate MyPostCard widget
            return MyPostCard(
              index: index,
              post: post,
              controller: controller,
            );
          },
        );
      }),
    );
  }
}
