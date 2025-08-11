import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/profile_singlaton.dart';
import 'name_screen.dart';

class LocationScreen extends StatelessWidget {
  Future<void> _handlePermission(BuildContext context) async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      try {
        // Get current location
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Save to singleton
        ProfileSingleton.instance.location =
        "${position.latitude}, ${position.longitude}";

        // Continue to next screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NameScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to get location: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permission denied")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(color: Colors.black), backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Share Your Location", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text("We use your location to show nearby profiles that actually match your energy", textAlign: TextAlign.center),
          SizedBox(height: 40),
          Image.asset('assets/map_icon.jpg', height: 200), // Replace with your asset
          Spacer(),
          ElevatedButton(
            onPressed: () => _handlePermission(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6D4376),
              padding: EdgeInsets.symmetric(vertical: 16),
              minimumSize: Size.fromHeight(50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
          ),
        ]),
      ),
    );
  }
}

