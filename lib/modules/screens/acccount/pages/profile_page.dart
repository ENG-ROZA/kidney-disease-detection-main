import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/layout/provider/app_provider.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/widgets/components.dart';
import 'package:graduation_project/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import '../../../../shared/network/local/cached_data.dart';
import '../../../../widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = "ProfilePage";

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _updatedNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    String token = CachedData.getFromCache("token");
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
          "Edit Profile",
          style: GoogleFonts.merriweather(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: ApiManager.getUserData(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              strokeWidth: 6,
              color: primaryColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final userData = snapshot.data?.results;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 150,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.network(
                        "${userData?.user?.profileImage?.url}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "${userData?.user?.userName}",
                    style: GoogleFonts.roboto(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${userData?.user?.email}",
                    style: GoogleFonts.roboto(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headTitlesOfTextField("Name"),
                        CustomTextFormField(
                          keyboardType: TextInputType.name,
                          suffixIcon: const Icon(
                            Icons.person_pin_rounded,
                            color: secondryColor,
                            size: 20,
                          ),
                          hintText: "Enter your name",
                          obscureText: false,
                          controller: _updatedNameController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Name must not be empty. Please try again.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70),
                  CustomButton(buttonText: "Update", onPressed: () {})
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
