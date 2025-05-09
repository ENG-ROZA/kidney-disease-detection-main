import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/core/helper/spaces.dart';
import 'package:graduation_project/core/theming/font_weight_helper.dart';
import 'package:graduation_project/core/theming/styles.dart';
import 'package:graduation_project/feature/comunity_screen/ui/screen/report_screen.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/like_icon.dart';

class CommentPostApp extends StatefulWidget {
  const CommentPostApp({
    Key? key,
    required this.profileImage,
    required this.profileName,
    required this.commentDate,
    required this.commentText,
    this.commentImage,
    required this.commentId,
    this.likesCount,
    required this.isLiked,
  }) : super(key: key);
  final String profileImage;
  final String profileName;
  final String commentDate;
  final String commentText;
  final String? commentImage;
  final int? likesCount;
  final String commentId;
  final bool isLiked;

  @override
  State<CommentPostApp> createState() => _CommentPostAppState();
}

class _CommentPostAppState extends State<CommentPostApp> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImage),
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xfff4f9fe)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "profileName",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeightHelper.bold,
                                        color: Colors.black,
                                        fontFamily: "Merriweather",
                                      ),
                                    ),
                                    verticalSpace(5),
                                    Text(" ${widget.commentDate}",
                                        style: const TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blueGrey)),
                                  ],
                                ),
                                horizontalSpace(160),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      ModalBottomSheetReport(context, []);
                                    },
                                    child: const Icon(
                                      Icons.report_outlined,
                                      size: 20,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                width: 280,
                                child: Text(
                                  widget.commentText,
                                  style: TextStyles.font18BlackboldMerriweather,
                                ),
                              ),
                              if (widget.commentImage != null &&
                                  widget.commentImage!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      widget.commentImage!,
                                      width: 250,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                            Icons.image_not_supported,
                                            size: 50,
                                            color: Colors.grey);
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 50, top: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                child: Container(
                  color: Colors.white,
                  child: LikeButton(
                    isLiked: widget.isLiked,
                    initialCount: widget.likesCount ?? 0,
                    id: widget.commentId,
                    type: 'Comment',
                  ),
                ),
              ),
              const Text(
                "Like",
                style: TextStyle(color: Colors.blueGrey),
              ),
              horizontalSpace(20),
              SvgPicture.asset(
                'assets/images/Vector.svg',
                height: 15,
              ),
              horizontalSpace(10),
              const Text(
                "Reply",
                style: TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
