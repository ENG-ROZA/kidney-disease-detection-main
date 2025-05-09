import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget doctorsItem(
    {required String image,
    required String name,
    required String address,
    required double rate,
    required String doctorId}) {
  return Card(
    elevation: 0.01,
    shadowColor: const Color(0xFFF7F8F8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    color: Colors.grey.shade200,
    child: Container(
      width: double.infinity,
      height: 135,
      margin: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16.0),
        //  border: Border.all(width: 0.5, color: const Color(0xFFC7C7C7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(image),
                ),
                const SizedBox(
                  width: 22.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: GoogleFonts.crimsonText(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      // address.length > 14 ? '${address.substring(0, 14)}...' : address,
                      address,
                      style: GoogleFonts.crimsonText(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow
                          .ellipsis, //! Note : if the address is too long, it will be truncated with an ellipsis
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                const Icon(
                  Icons.star,
                  color: Color(0xFFFCB551),
                  size: 15.0,
                ),
                const SizedBox(
                  width: 3.5,
                ),
                Text("$rate",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF080C2F),
                    )),
                const Spacer(),
                Container(
                    width: 55,
                    height: 32,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text('Details',
                        style: GoogleFonts.poppins(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF222E54),
                        ))),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  width: 49,
                  height: 32,
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: const Icon(
                    Icons.location_on,
                    color: Color(0xFF2f79e8),
                    size: 20.0,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    ),
  );
}
