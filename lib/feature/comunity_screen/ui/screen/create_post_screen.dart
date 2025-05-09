import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:graduation_project/core/helper/spaces.dart';
import 'package:graduation_project/core/services/create_post.dart';
import 'package:graduation_project/core/services/update_post_service.dart';
import 'package:graduation_project/core/theming/font_weight_helper.dart';
import 'package:graduation_project/core/theming/styles.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/post_model.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/update_post_request.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/camera_Button_sheet.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/profile_image.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/tgs_box_text.dart';
import 'package:graduation_project/widgets/message/messages_methods.dart';

class CreatePostScreen extends StatefulWidget {
  static const String routeName = "/CreatePostScreen";

  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String? selectedItemTwo = '  public';
  File? postImage;

  List<String> itemsTwo = [
    '  public',
    '  private',
  ];

  CreatePostDataNeed? allData;
  PostModel? postData;

  String? profileImage;
  String? editPostImage;
  RxString selectedOption = "None".obs;

  final RxBool isTagsVisible = false.obs;
  final RxBool isPostEnabled = false.obs;

  final TextEditingController postController = TextEditingController();

  Color getTagColor(String tag) {
    switch (tag) {
      case "Healing story":
        return const Color(0xffc9e9d6);
      case "Question":
        return const Color(0xffd5dbf5);
      case "Advice":
        return const Color(0xfffee2bb);
      default:
        return Colors.transparent;
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() {
  //     final args =
  //         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  //     if (args != null && args['profileImage'] != null) {
  //       setState(() {
  //         profileImage = args['profileImage'];
  //       });
  //     }
  //   });
  // }

  bool isFirst = false;
  @override
  void didChangeDependencies() {
    if (!isFirst) {
      allData =
          ModalRoute.of(context)?.settings.arguments as CreatePostDataNeed;
      postData = allData?.postModel;
      if (postData?.media.isNotEmpty == true) {
        editPostImage = postData?.media[0].url ?? "";
      }
      postController.text = postData?.content ?? "";
      profileImage = allData?.profileImage;
      selectedOption = postData?.tag.obs ?? "None".obs;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            verticalSpace(30),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
                Text(
                  (allData?.postModel == null)
                      ? "   Create post"
                      : "   Edit post",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeightHelper.bold,
                    color: const Color(0xff666666),
                    fontFamily: "Merriweather",
                  ),
                ),
                Expanded(flex: 3, child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: Obx(() => SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: isPostEnabled.value
                              ? () async {
                                  if (allData?.postModel != null) {
                                    if (selectedOption.value == "None") {
                                      showErrorMessage(context, "Tag required");

                                      return;
                                    }
                                    UpdatePostService.updatePost(
                                      postId: postData!.id,
                                      requestData: UpdatePostRequest(
                                        content: postController.text.trim(),
                                        tag: selectedOption.value,
                                        media: postImage,
                                      ),
                                    ).then((value) {
                                      showSuccessMessage(
                                          context, 'Post updated successfully');
                                      Navigator.pop(context);
                                    }).catchError((e) {
                                      showErrorMessage(
                                          context, "something went wrong");
                                    });
                                    return;
                                  }
                                  if (selectedOption.value == "None") {
                                    print('No tag selected');
                                    showErrorMessage(context, "Tag required");
                                    return;
                                  }

                                  try {
                                    print('Creating post...');
                                    await CreatePostServices()
                                        .createPost(
                                      tag: selectedOption.value,
                                      content: postController.text.trim(),
                                      mediaFile: postImage,
                                    )
                                        .then((value) {
                                      showSuccessMessage(
                                          context, 'Post created successfully');
                                    }).catchError((e) {
                                      print('Error while creating post: $e');
                                      showErrorMessage(
                                          context, "something went wrong");
                                    });
                                    Navigator.pop(context);
                                  } catch (e) {
                                    print('Error while creating post: $e');
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isPostEnabled.value
                                ? Colors.blue
                                : Colors.blueGrey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3,
                            shadowColor: Colors.blue.withOpacity(0.5),
                          ),
                          child: Text(
                            allData?.postModel == null ? "post" : "edit",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Merriweather",
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      )),
                )
              ],
            ),
            verticalSpace(20),
            Row(
              children: [
                if (profileImage != null)
                  ProfileImageDesign(image: profileImage!)
                else
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(),
                  ),
                horizontalSpace(5),
                Container(
                  height: 30,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton<String>(
                    value: selectedItemTwo,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItemTwo = newValue!;
                      });
                    },
                    items:
                        itemsTwo.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const Spacer(),
                CameraModelBottonSheet(
                  onImagePicked: (path) {
                    setState(() {
                      postImage = path;
                      editPostImage = null;
                    });
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: 230,
                    constraints: const BoxConstraints(
                      minHeight: 40,
                      maxHeight: 150,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: postController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        isPostEnabled.value = value.trim().isNotEmpty;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        border: InputBorder.none,
                        hintText: "What's on your mind?",
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Obx(() => selectedOption.value != "None"
                    ? Container(
                        alignment: Alignment.center,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: getTagColor(selectedOption.value),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            selectedOption.value,
                            style: TextStyles.font20greyregularMerriweather,
                          ),
                        ),
                      )
                    : const SizedBox()),
              ],
            ),
            verticalSpace(20),
            if (postImage != null)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    postImage!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else if (editPostImage != null)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    editPostImage!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    isTagsVisible.value = !isTagsVisible.value;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    shadowColor: Colors.blue.withOpacity(0.5),
                  ),
                  child: const Text(
                    "Add tags",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Merriweather",
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => isTagsVisible.value
                ? Column(
                    children: [
                      RadioListTile(
                        title: const TagsBoxText(
                            tag: 'None', tagColor: Colors.white),
                        value: "None",
                        groupValue: selectedOption.value,
                        onChanged: (value) {
                          selectedOption.value = value!;
                          isTagsVisible.value = false;
                        },
                      ),
                      RadioListTile(
                        title: const TagsBoxText(
                            tag: 'Healing stories',
                            tagColor: Color(0xffc9e9d6)),
                        value: "Healing stories",
                        groupValue: selectedOption.value,
                        onChanged: (value) {
                          selectedOption.value = value!;
                          isTagsVisible.value = false;
                        },
                      ),
                      RadioListTile(
                        title: const TagsBoxText(
                            tag: 'Question', tagColor: Color(0xffd5dbf5)),
                        value: "Question",
                        groupValue: selectedOption.value,
                        onChanged: (value) {
                          selectedOption.value = value!;
                          isTagsVisible.value = false;
                        },
                      ),
                      RadioListTile(
                        title: const TagsBoxText(
                            tag: 'Advice', tagColor: Color(0xfffee2bb)),
                        value: "Advice",
                        groupValue: selectedOption.value,
                        onChanged: (value) {
                          selectedOption.value = value!;
                          isTagsVisible.value = false;
                        },
                      ),
                    ],
                  )
                : const SizedBox()),
          ],
        ),
      ),
    );
  }
}

class CreatePostDataNeed {
  final PostModel? postModel;

  final String profileImage;

  CreatePostDataNeed({this.postModel, required this.profileImage});
}
