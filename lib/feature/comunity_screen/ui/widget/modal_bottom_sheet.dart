import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/core/helper/spaces.dart';
import 'package:graduation_project/core/services/create_comment.dart';
import 'package:graduation_project/core/theming/styles.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/comment_model.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/comment_post_app.dart';

void ModalBottomSheet(
    BuildContext context, List<CommentModel> comments, String postId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final TextEditingController _commentController = TextEditingController();

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: FractionallySizedBox(
              heightFactor: 1,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalSpace(50),
                    Container(
                      width: 180,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    verticalSpace(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Comments",
                              style: TextStyles.font18BlackboldMerriweather),
                          Text("Most Recent",
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 12)),
                        ],
                      ),
                    ),
                    verticalSpace(10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: comments.isEmpty
                            ? Center(
                                child: Text("No comments yet.",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16)))
                            : ListView.builder(
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  final comment = comments[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: CommentPostApp(
                                      isLiked: comment.isLiked,
                                      commentId: comment.id,
                                      likesCount: comment.likesCount,
                                      profileImage:
                                          comment.user.profileImage.url,
                                      profileName: comment.user.userName,
                                      commentDate:
                                          "${comment.createdAt.hour}:${comment.createdAt.minute}",
                                      commentText: comment.content,
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(
                                color: Colors.grey.shade300, width: 1)),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/camera.svg',
                              height: 24),
                          horizontalSpace(10),
                          SvgPicture.asset('assets/images/face-smile.svg',
                              height: 24),
                          horizontalSpace(10),
                          Expanded(
                            child: Container(
                              constraints:
                                  BoxConstraints(minHeight: 40, maxHeight: 150),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: _commentController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  border: InputBorder.none,
                                  hintText: "Write a comment...",
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                          ),
                          horizontalSpace(10),
                          GestureDetector(
                            onTap: () async {
                              final commentText =
                                  _commentController.text.trim();
                              if (commentText.isNotEmpty) {
                                try {
                                  final newComment =
                                      await CreateCommentServices()
                                          .createComment(
                                              content: commentText,
                                              postId: postId);
                                  setState(() {
                                    comments.add(newComment);
                                  });
                                  _commentController.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Comment posted successfully"),
                                        backgroundColor: Colors.green),
                                  );
                                } catch (e) {
                                  print("Error posting comment: $e");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Failed to post comment"),
                                        backgroundColor: Colors.red),
                                  );
                                }
                              }
                            },
                            child: SvgPicture.asset(
                                'assets/images/telegram-logo-light.svg',
                                height: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
