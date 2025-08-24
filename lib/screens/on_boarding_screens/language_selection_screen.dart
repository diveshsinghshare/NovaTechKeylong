import 'package:flutter/material.dart';
import '../../models/profile_singlaton.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final List<String> preselected;

  const LanguageSelectionScreen({Key? key, this.preselected = const []})
      : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final List<String> _allLanguages = [
    "English",
    "Hindi",
    "Bengali",
    "Marathi",
    "Telugu",
    "Tamil",
    "Gujarati",
    "Urdu",
    "Kannada",
    "Odia",
    "Malayalam",
    "Punjabi",
    "Assamese",
    "Maithili",
    "Santali",
    "Kashmiri",
    "Nepali",
    "Konkani",
    "Sindhi",
    "Dogri",
    "Manipuri",
    "Bodo",
    "Sanskrit",
  ];

  late List<String> _selectedLanguages;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _selectedLanguages = List.from(widget.preselected);
  }

  void _finishSelection() {
    // ✅ Save into ProfileSingleton
    ProfileSingleton.instance.selectedLanguages = _selectedLanguages;

    // return for local UI update
    Navigator.pop(context, _selectedLanguages);
  }

  @override
  Widget build(BuildContext context) {
    final filteredLanguages = _allLanguages
        .where((lang) =>
        lang.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _finishSelection,
        ),
        title: const Text("Select Languages",
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Do you prefer people who speak a particular language?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "You can select up to 3 languages",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // search field
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search your languages",
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() => _searchQuery = "");
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
            const SizedBox(height: 16),

            // list of checkboxes
            Expanded(
              child: ListView.builder(
                itemCount: filteredLanguages.length,
                itemBuilder: (context, index) {
                  final language = filteredLanguages[index];
                  final isSelected = _selectedLanguages.contains(language);

                  return CheckboxListTile(
                    title: Text(language),
                    value: isSelected,
                    activeColor: Colors.deepPurple,
                    onChanged: (selected) {
                      setState(() {
                        if (selected == true) {
                          if (_selectedLanguages.length < 3) {
                            _selectedLanguages.add(language);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "You can select up to 3 languages only"),
                              ),
                            );
                          }
                        } else {
                          _selectedLanguages.remove(language);
                        }
                      });
                    },
                  );
                },
              ),
            ),

            // Done button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _finishSelection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
