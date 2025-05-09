import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:graduation_project/core/helper/spaces.dart';
import 'package:graduation_project/core/services/get_all_posts.dart';
import 'package:graduation_project/core/services/get_user_posts_data_service.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/post_model.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/user_data_model.dart';
import 'package:graduation_project/feature/comunity_screen/ui/screen/create_post_screen.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/post_community_app.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/ProfileScreen";
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<PostModel>> futurePosts;
  late String userId;
  @override
  void initState() {
    super.initState();
  }

  bool isFirst = false;
  @override
  void didChangeDependencies() async {
    if (!isFirst) {
      userId = ModalRoute.of(context)?.settings.arguments as String;
      futurePosts = AllPostsServices().getAllPosts(userId: userId);

      isFirst = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_sharp, size: 18),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder<List<PostModel>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('There was an error'));
          }

          final posts = snapshot.data;
          if (posts == null || posts.isEmpty) {
            return Center(child: Text('No posts available.'));
          }

          final firstUserId = posts.first.user.id;

          final userPosts =
              posts.where((post) => post.user.id == firstUserId).toList();

          if (userPosts.isEmpty) {
            return Center(child: Text('No posts available for this user.'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header with image and user info
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 200.h,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/Mask group.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -60,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  posts.first.user.profileImage.url,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.camera_alt, size: 15),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 70), // to make room for CircleAvatar

                // Username
                Text(
                  posts.first.user.userName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(10),

                // Add Post Button
                SizedBox(
                  width: 170.w,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        CreatePostScreen.routeName,
                        arguments: CreatePostDataNeed(
                            profileImage: posts.first.user.profileImage.url),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, color: Colors.blueGrey),
                        SizedBox(width: 5),
                        Text(
                          'Add Post',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                ),

                verticalSpace(20),

                // Posts List
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userPosts.length,
                  itemBuilder: (context, index) {
                    final post = userPosts[index];
                    return PostCommunityApp(
                      updateUi: () {
                        setState(() {
                          futurePosts = AllPostsServices()
                              .getAllPosts(isAllCommunity: true);
                        });
                      },
                      post: post,
                      profileImage: post.user.profileImage.url,
                      profileName: post.user.userName,
                      postDate: '${post.createdAt.day}/${post.createdAt.month}',
                      tag: post.tag,
                      tagColor: Color(0xFFd5dbf5),
                      postText: post.content,
                      postImage:
                          post.media.isNotEmpty ? post.media[0].url : null,
                      likesCount: post.likesCount,
                      commentCount: post.commentCount,
                    );
                  },
                ),
                verticalSpace(30),
              ],
            ),
          );
        },
      ),
    );
  }
}
