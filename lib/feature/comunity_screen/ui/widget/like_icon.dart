import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/core/services/toggle_like_service.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';

class LikeButton extends StatefulWidget {
  final int initialCount;
  final String id;
  final String type;
  bool isLiked;

  LikeButton({
    super.key,
    required this.initialCount,
    required this.id,
    required this.type,
    required this.isLiked,
  });

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  // bool isLiked = false;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    likeCount = widget.initialCount;
  }

  void toggleLike() {
    setState(() {
      widget.isLiked = !widget.isLiked;
      likeCount += widget.isLiked ? 1 : -1;
      ToggleLikeService.toggleLike(id: widget.id, type: widget.type)
          .then((value) {
        showSuccessMessage(context, 'Add Like Success');
      }).catchError((e) {
        showErrorMessage(context, e.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleLike,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/like_icon.svg',
            height: 18,
            color: widget.isLiked ? Colors.red : Colors.grey,
          ),
          SizedBox(width: 4),
          Text(
            ' $likeCount     ',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
