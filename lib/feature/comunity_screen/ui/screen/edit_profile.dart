import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/core/helper/spaces.dart';
import 'package:graduation_project/core/theming/styles.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/profile_image.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/tgs_box_text.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = "/EditProfile";
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? selectedItemTwo = '  public';

  List<String> itemsTwo = [
    '  public',
    '  private',
  ];
  final RxString selectedOption = "None".obs;

  final RxBool isTagsVisible = false.obs;

  final RxBool isPostEnabled = false.obs;

  final TextEditingController postController = TextEditingController();

  Color getTagColor(String tag) {
    switch (tag) {
      case "Healing stories":
        return const Color(0xffc9e9d6);
      case "Question":
        return const Color(0xffd5dbf5);
      case "Advice":
        return const Color(0xfffee2bb);
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_sharp, size: 18)),
        backgroundColor: Colors.white,
        title: Text(
          "Edite post",
          style: TextStyles.font20BlackBoldMerriweather,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              width: 100,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2f79e8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  shadowColor: Colors.blue.withOpacity(0.5),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Merriweather",
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const ProfileImageDesign(image: "assets/images/person8.png"),
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
                // CameraModelBottonSheet(),
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
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
                        title: const TagsBoxText(tag: 'None', tagColor: Colors.white),
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
