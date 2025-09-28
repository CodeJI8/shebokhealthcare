import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'members_controller.dart';

class ThalassemiaScreen extends StatelessWidget {
  final MembersController controller = Get.put(MembersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red[900]),
          onPressed: () => Get.back(),
        ),
        title: Text("Thalassemia", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            width: 82,
            height: 27,
            child: TextButton(
              onPressed: controller.joinNow,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white, // Set background to white
               // Set width and height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Rounded corners
                  side: BorderSide(color: Colors.red, width: 2), // Red border with thickness // Red border with thickness
                ),
              ),
              child: Text(
                "Join Now",
                style: TextStyle(
                  color: Colors.black, // Text color set to black
                ),
              ),
            ),
          ),

          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                    !controller.isLoading.value) {
                  controller.fetchMembers(loadMore: true); // 🚀 load next page
                }
                return false;
              },
              child: ListView.builder(
                itemCount: controller.members.length + 1,
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  if (index < controller.members.length) {
                    final member = controller.members[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(member.imageUrl),
                          radius: 28,
                        ),
                        title: Text(
                          member.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(member.phone),
                            Text(
                              member.bloodGroup,
                              style: TextStyle(
                                color: Colors.red[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () => controller.callMember(member.phone),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            "Call Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return controller.hasMore.value
                        ? Padding(
                      padding: const EdgeInsets.all(12.0),

                    )
                        : SizedBox.shrink();
                  }
                },
              ),
            )),
          ),


          /// Bottom Button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: controller.registerNow,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[900],

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                "Register Now",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
