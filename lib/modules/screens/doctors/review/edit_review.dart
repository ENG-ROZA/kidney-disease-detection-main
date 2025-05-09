import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditReview extends StatelessWidget {
  static const String routeName = 'UpdateReview';

  final _formKey = GlobalKey<FormState>();
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
        title: Text(
          "Update Review",
          style: GoogleFonts.merriweather(
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                const CircleAvatar(
                    backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                )),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  "eng ahmed",
                  style: GoogleFonts.crimsonText(
                      fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const Spacer(),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15,
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorErrorColor: const Color(0xFFFF3B30),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Your Review must not be empty';
                  }
                  return null;
                },
                maxLength: 157,
                cursorColor: Colors.black,
                maxLines: 5,
                style: GoogleFonts.amiri(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    errorStyle: GoogleFonts.amiri(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFFF3B30),
                    ),
                    suffix: IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.edit_square,
                          size: 20, color: Colors.black.withOpacity(0.5)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) return;
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5), width: 1.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5), width: 1.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    hintText: "Update Your Review",
                    helperStyle: GoogleFonts.amiri(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
