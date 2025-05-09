import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/widgets/custom_button.dart';
import 'package:graduation_project/widgets/text_field.dart';

class Egfr extends StatefulWidget {
  static const String routeName = 'egfr';

  const Egfr({super.key});
  @override
  _EGFRScreenState createState() => _EGFRScreenState();
}

class _EGFRScreenState extends State<Egfr> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _creatinineController = TextEditingController();
  bool _isMale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
           surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          "eGFR Calculator",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "eGFR",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "This tool helps you to know your kidney status according to eGFR.It needs some information about you to calculate your eGFR to know your kidney status.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: GoogleFonts.merriweather(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio<bool>(
                              activeColor: primaryColor,
                              value: true,
                              groupValue: _isMale,
                              onChanged: (value) =>
                                  setState(() => _isMale = value!),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Male',
                              style: GoogleFonts.merriweather(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.male,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            const SizedBox(
                              width: 70,
                            ),
                            Radio<bool>(
                              activeColor: primaryColor,
                              value: false,
                              groupValue: _isMale,
                              onChanged: (value) =>
                                  setState(() => _isMale = value!),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Female',
                              style: GoogleFonts.merriweather(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.female,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Text(
                          'Age',
                          style: GoogleFonts.merriweather(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        CustomTextFormField(
                          controller: _ageController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          hintText: "Age",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Invalid age';
                            }
                            if (int.parse(value) < 18) return 'Age Must be 18+';
                            return null;
                          },
                          obscureText: false,
                          suffixIcon: const Icon(Icons.calendar_month),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Serum Creatinine',
                          style: GoogleFonts.merriweather(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        CustomTextFormField(
                          controller: _creatinineController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          obscureText: false,
                          hintText: "Serum Creatinine",
                          suffixIcon: const Icon(Icons.bloodtype),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Invalid value';
                            }
                            if (double.parse(value) <= 0) {
                              return 'Must be positive';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 35),
                        CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                calculateEGFR();
                              }
                            },
                            buttonText: 'Calculate'),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateEGFR() {
    int age = int.parse(_ageController.text);
    double creatinine = double.parse(_creatinineController.text);
    bool isFemale = !_isMale;

    double egfr = 175 *
        pow(creatinine, -1.154) *
        pow(age, -0.203) *
        (isFemale ? 0.742 : 1);

    String interpretation;
    if (egfr >= 90) {
      interpretation = 'Normal kidney';
    } else if (egfr >= 60) {
      interpretation = 'Mild decrease';
    } else if (egfr >= 30) {
      interpretation = 'Moderate decrease (Stage 3)';
    } else if (egfr >= 15) {
      interpretation = 'Severe decrease (Stage 4)';
    } else {
      interpretation = 'Kidney failure (Stage 5)';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.center, children: [
              Image.asset("assets/images/result.png"),
              Text(
                'Result',
                style: GoogleFonts.merriweather(
                    fontSize: 20, fontWeight: FontWeight.bold),
              )
            ]),
            const SizedBox(height: 15),
            Text(
              'eGFR Value (ml/min/1.73m*2) \n = ${egfr.toStringAsFixed(1)}',
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              "Kidney Function Level  \n '$interpretation'",
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Center(
            child: CustomButton(
                onPressed: () => Navigator.pop(context), buttonText: 'Done'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _creatinineController.dispose();
    super.dispose();
  }
}
