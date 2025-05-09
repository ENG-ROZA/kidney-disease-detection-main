import 'package:flutter/material.dart';
import 'package:graduation_project/core/services/create_post.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14), topRight: Radius.circular(14)),
        color: Colors.grey.shade50,
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              print('1');

              CreatePostServices().createPost(
                tag: "Advice",
                content: "AbdElrahman",
              );
            },
            child: Icon(
              Icons.home_sharp,
              size: 30,
              color: Colors.grey,
            ),
          ),
          Icon(
            Icons.history,
            size: 30,
            color: Colors.grey,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
