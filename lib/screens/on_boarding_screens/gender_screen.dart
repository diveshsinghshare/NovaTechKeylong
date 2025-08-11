
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:novatech/welcome.dart';
import '../../models/profile_singlaton.dart';
import 'interested_screen.dart';

class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(color: Colors.black), backgroundColor: Colors.white, elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("How do you identify yourself?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("It’s the one thing you can’t edit later."),
            SizedBox(height: 24),
            _buildOption("Man"),
            _buildOption("Woman"),
            SizedBox(height: 12),
            Text("Learn Why nova asks for this Info", style: TextStyle(color: Colors.purple.shade900, fontSize: 12)),
            Spacer(),
            ElevatedButton(
              onPressed: selected == null
                  ? null
                  : () {
                ProfileSingleton.instance.gender = selected ?? "Men";

                Navigator.push(context, MaterialPageRoute(builder: (_) => InterestedInScreen()));
              },
              child: Text("Continue", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6D4376),
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String label) {
    final isSelected = selected == label;
    return GestureDetector(
      onTap: () => setState(() => selected = label),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: TextStyle(fontSize: 16))),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.purple),
                color: isSelected ? Colors.purple : Colors.transparent,
              ),
              child: isSelected ? Icon(Icons.check, size: 14, color: Colors.white) : null,
            )
          ],
        ),
      ),
    );
  }
}
// interested_in_screen.dart

