import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/core/helper/spaces.dart';
import 'package:graduation_project/core/theming/styles.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/post_model.dart';
import 'package:graduation_project/feature/comunity_screen/ui/screen/create_post_screen.dart';
import 'package:graduation_project/feature/comunity_screen/ui/screen/profile_screen.dart';
import 'package:graduation_project/feature/comunity_screen/ui/screen/report_screen.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/like_icon.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/modal_bottom_sheet.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/profile_image.dart';

class PostCommunityApp extends StatelessWidget {
  const PostCommunityApp(
      {super.key,
      required this.profileImage,
      required this.profileName,
      required this.postDate,
      required this.tag,
      required this.tagColor,
      required this.postText,
      this.postImage,
      required this.likesCount,
      required this.commentCount,
      required this.post,
      this.userId,
      this.back,
      required this.updateUi});
  final String profileImage;
  final String profileName;
  final String postDate;
  final String tag;
  final Color tagColor;
  final PostModel post;
  final String postText;
  final String? postImage;
  final int likesCount;
  final int commentCount;
  final String? userId;
  final VoidCallback updateUi;

  final VoidCallback? back;
  Color getTagColor(String tag) {
    switch (tag) {
      case "Healing story":
        return Color(0xffc9e9d6);
      case "Question":
        return Color(0xffd5dbf5);
      case "Advice":
        return Color(0xfffee2bb);
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                top: 10,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName,
                          arguments: userId);
                    },
                    child: ProfileImageDesign(
                      image: profileImage,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profileName,
                            style: TextStyles.font20greyregularMerriweather),
                        verticalSpace(4),
                        Row(
                          children: [
                            Text("$postDate ",
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blueGrey)),
                            SvgPicture.asset(
                              'assets/images/earth.svg',
                              height: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: getTagColor(tag)),
                    child: Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Text(
                          tag,
                          style: TextStyles.font20greyregularMerriweather,
                        )),
                  ),
                  horizontalSpace(5),
                  if (post.myOwnPost)
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(CreatePostScreen.routeName,
                                  arguments: CreatePostDataNeed(
                                      postModel: post,
                                      profileImage: profileImage))
                              .then((value) {
                            if (back != null) back!();
                          });

                          print('got to edit post');
                        },
                        child: Icon(Icons.edit)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        ModalBottomSheetReport(context, post.comments);
                      },
                      child: Icon(
                        Icons.report_outlined,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, top: 12),
              child: Text(
                postText,
                style: TextStyles.font20greyregularMerriweather,
              ),
            ),
            if (postImage?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: postImage!.startsWith('http')
                        ? Image.network(
                            postImage!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(
                            postImage!,
                            height: 200,
                          )),
              ),
            Divider(
              color: Colors.grey.shade100,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
              child: GestureDetector(
                onTap: () {
                  ModalBottomSheet(context, post.comments, post.id);
                },
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Row(
                    children: [
                      LikeButton(
                        isLiked: post.isLiked,
                        initialCount: likesCount,
                        id: post.id,
                        type: 'Post',
                      ),
                      SvgPicture.asset(
                        'assets/images/comment_icon.svg',
                        height: 15,
                      ),
                      Text(
                        "  $commentCount",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
