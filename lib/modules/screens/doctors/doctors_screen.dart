import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/models/doctors_model.dart';
import 'package:graduation_project/modules/screens/doctors/doctors_item.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'doctors_details.dart';

class DoctorsScreen extends StatefulWidget {
  static const String routeName = 'doctors';
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  late Future<DoctorsResponse> _doctorsFuture;

  @override
  void initState() {
    _doctorsFuture = ApiManager.getDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Top Doctors",
          style: GoogleFonts.merriweather(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _doctorsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Skeletonizer(
                switchAnimationConfig: const SwitchAnimationConfig(
                  switchInCurve: Curves.bounceIn,
                  switchOutCurve: Curves.easeInOutCirc,
                ),
                enabled: true,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: 8, //! Show 8 skeleton items
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const ListTile(
                      leading: Skeleton.leaf(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      title: Skeleton.leaf(
                        child: Text(
                          'Dr. Doctor Name',
                          style: TextStyle(color: Colors.transparent),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeleton.leaf(
                            child: Text(
                              'Specialty, Hospital',
                              style: TextStyle(color: Colors.transparent),
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Skeleton.leaf(
                                child: Icon(Icons.star,
                                    color: Color(0xFFFCB551), size: 18),
                              ),
                              SizedBox(width: 4),
                              Skeleton.leaf(
                                child: Text(
                                  '4.5',
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final doctors = snapshot.data?.results ?? [];
          return doctors.isEmpty
              ? const Center(child: Text('No doctors found'))
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: doctors.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DoctorsDetails.routeName,
                                  arguments: doctors[index].id,
                                );
                              },
                              child: doctorsItem(
                                address: doctors[index].address ?? "",
                                image: doctors[index].image?.url ?? "",
                                name: doctors[index].name ?? "",
                                rate: doctors[index].avgRating ?? 0.0,
                                doctorId: doctors[index].id ?? "",
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
