import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/helper/spaces.dart';
import 'package:graduation_project/core/theming/font_weight_helper.dart';
import 'package:graduation_project/core/theming/styles.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/comment_model.dart';
import 'package:graduation_project/feature/comunity_screen/ui/widget/chouse_report.dart';

void ModalBottomSheetReport(BuildContext context, List<CommentModel> comments) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) => ReportBottomSheetContent(),
  );
}

class ReportBottomSheetContent extends StatefulWidget {
  @override
  State<ReportBottomSheetContent> createState() =>
      _ReportBottomSheetContentState();
}

class _ReportBottomSheetContentState extends State<ReportBottomSheetContent> {
  String? selectedValue;
  bool showTextField = false;
  TextEditingController otherReasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              verticalSpace(10),
              Text("Report", style: TextStyles.font20BlackBoldMerriweather),
              Divider(),
              Text(
                "What is the reason you want to report this user?",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeightHelper.bold,
                  fontFamily: "Merriweather",
                ),
              ),
              verticalSpace(10),

              /// اختيارات التقرير
              if (!showTextField) ...[
                ChouseTheReport(
                  selectedValue: selectedValue ?? '',
                  mainText: "Spam",
                  subText:
                      "This user is sending repeated, irrelevant, or promotional messages.",
                  onChanged: (value) => setState(() => selectedValue = value),
                ),
                ChouseTheReport(
                  selectedValue: selectedValue ?? '',
                  mainText: "Harassment",
                  subText:
                      "This user is being abusive or making you feel uncomfortable.",
                  onChanged: (value) => setState(() => selectedValue = value),
                ),
                ChouseTheReport(
                  selectedValue: selectedValue ?? '',
                  mainText: "Fake Account",
                  subText:
                      "This profile contains false or misleading identity.",
                  onChanged: (value) => setState(() => selectedValue = value),
                ),
                ChouseTheReport(
                  selectedValue: selectedValue ?? '',
                  mainText: "Inappropriate Content",
                  subText: "Offensive language, images, or behavior.",
                  onChanged: (value) => setState(() => selectedValue = value),
                ),
                ChouseTheReport(
                  selectedValue: selectedValue ?? '',
                  mainText: "Other",
                  subText: "Something else not listed above.",
                  onChanged: (value) => setState(() => selectedValue = value),
                ),
                verticalSpace(20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    if (selectedValue == "Other") {
                      setState(() => showTextField = true);
                    } else if (selectedValue != null) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Report submitted successfully.")),
                      );
                    }
                  },
                  child: Text(
                    "Report",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeightHelper.bold,
                      color: Colors.white,
                      fontFamily: "Merriweather",
                    ),
                  ),
                ),
              ] else ...[
                verticalSpace(10),
                Text(
                  "Please specify your reason:",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeightHelper.bold,
                    fontFamily: "Merriweather",
                  ),
                ),
                verticalSpace(10),
                TextField(
                  controller: otherReasonController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your reason...",
                  ),
                  maxLines: 3,
                ),
                verticalSpace(20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    print("Custom reason: ${otherReasonController.text}");
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Report submitted successfully.")),
                    );
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeightHelper.bold,
                      color: Colors.white,
                      fontFamily: "Merriweather",
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
