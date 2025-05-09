import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MapImage extends StatelessWidget {
  final String? latitude;
  final String? longitude;
  final String? apiKey;
  const MapImage({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.apiKey,
  });

  Future<void> _launchMap() async {
    //! Google Maps app 
    final Uri mapUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );

    try {
      if (await canLaunchUrl(mapUrl)) {
        await launchUrl(mapUrl);
      } else {
        //! Google Maps website
        final Uri webUrl = Uri.parse(
          "https://www.google.com/maps/@$latitude,$longitude,15z",
        );
        await launchUrl(webUrl);
      }
    } catch (e) {
      print("Error launching map: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchMap,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            "https://maps.googleapis.com/maps/api/staticmap"
            "?center=$latitude,$longitude"
            "&zoom=15"
            "&size=600x300"
            "&markers=color:red%7C$latitude,$longitude"
            "&key=$apiKey", 
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Image(image: AssetImage('assets/images/map_image.png'), fit: BoxFit.cover,width: double.infinity,));
            },
          ),
        ),
      ),
    );
  }
}
