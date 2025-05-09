import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:graduation_project/core/helper/spaces.dart';
import 'package:graduation_project/core/services/get_all_posts.dart';
import 'package:graduation_project/core/theming/styles.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/post_model.dart';
import 'package:graduation_project/feature/comunity_screen/ui/screen/create_post_screen.dart';
import 'package:graduation_project/feature/comunity_screen/ui/screen/opacity_welcom_screen.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/notifications_icon.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/post_community_app.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/profile_add_post.dart';
import 'package:graduation_project/shared/utils/colors.dart';

class CommunityScreen extends StatefulWidget {
  static const String routeName = "/CommunityScreen";
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool showOverlay = true;
  late Future<List<PostModel>> futurePosts;

  void hideOverlay() {
    setState(() {
      showOverlay = false;
      futurePosts = AllPostsServices().getAllPosts(isAllCommunity: true);
    });
  }

  @override
  void initState() {
    super.initState();
    futurePosts = AllPostsServices().getAllPosts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!showOverlay && ModalRoute.of(context)?.isCurrent == true) {
      setState(() {
        futurePosts = AllPostsServices().getAllPosts(isAllCommunity: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_sharp, size: 18)),
            backgroundColor: Colors.white,
            title: Text("community",
                style: TextStyles.font20BlackBoldMerriweather),
            centerTitle: true,
            // actions: [NotificationsIconAppBare()],
          ),
          body: showOverlay
              ? SizedBox.shrink()
              : FutureBuilder<List<PostModel>>(
                  future: futurePosts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      final height = MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          MediaQuery.of(context).padding.top;
                      return const Center(
                          child: CircularProgressIndicator(
                        color: primaryColor,
                        strokeCap: StrokeCap.round,
                        strokeWidth: 6,
                      ));
                    }

                    if (snapshot.hasError) {
                      Future.microtask(() {
                        Get.toNamed("/NoNetworkScreen");
                      });
                      return SizedBox.shrink();
                    }

                    final posts = snapshot.data;
                    if (posts == null || posts.isEmpty) {
                      return Center(child: Text('No posts available.'));
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              // await Get.toNamed(
                              //   "/CreatePostScreen",
                              //   arguments: {
                              //     "profileImage":
                              //         posts.first.user.profileImage.url,
                              //   },
                              // );
                              Navigator.pushNamed(
                                context,
                                CreatePostScreen.routeName,
                                arguments: CreatePostDataNeed(
                                    profileImage:
                                        posts.first.user.profileImage.url),
                              ).then((value) {
                                setState(() {
                                  futurePosts = AllPostsServices()
                                      .getAllPosts(isAllCommunity: true);
                                });
                              });
                            },
                            child: ProfileAndAddPost(
                              image: posts.first.user.profileImage.url,
                            ),
                          ),
                          verticalSpace(30),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              final post = posts[index];
                              return PostCommunityApp(
                                updateUi: () {
                                  setState(() {
                                    futurePosts = AllPostsServices()
                                        .getAllPosts(isAllCommunity: true);
                                  });
                                },
                                back: () {
                                  setState(() {
                                    futurePosts = AllPostsServices()
                                        .getAllPosts(isAllCommunity: true);
                                  });
                                },
                                userId: post.user.id,
                                post: post,
                                profileImage: post.user.profileImage.url,
                                profileName: post.user.userName,
                                postDate:
                                    '${post.createdAt.day}/${post.createdAt.month}',
                                tag: post.tag,
                                tagColor: Color(0xFFd5dbf5),
                                postText: post.content,
                                postImage: post.media.isNotEmpty
                                    ? post.media[0].url
                                    : null,
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
          // bottomNavigationBar: AppBottomNavigationBar(),
        ),
        if (showOverlay) OpacityWelcomScreen(onClose: hideOverlay),
      ],
    );
  }
}
