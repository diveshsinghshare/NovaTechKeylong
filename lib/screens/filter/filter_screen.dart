import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Example filter values
  RangeValues _ageRange = const RangeValues(18, 30);
  double _distance = 30;
  bool _verifiedOnly = false;

  double _preferredHeight = 170;
  bool _hasBio = false;
  bool _hasVoice = false;
  bool _hasVideo = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            alignment: Alignment.center,
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.purple,
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: "Basic filters"),
                Tab(text: "Advanced filters"),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // BASIC FILTERS TAB
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      const Text(
                        "What age range feels right for you?",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text("Age range ${_ageRange.start.toInt()} - ${_ageRange.end.toInt()}"),
                      RangeSlider(
                        values: _ageRange,
                        min: 18,
                        max: 60,
                        divisions: 42,
                        labels: RangeLabels(
                          "${_ageRange.start.toInt()}",
                          "${_ageRange.end.toInt()}",
                        ),
                        onChanged: (RangeValues values) {
                          setState(() => _ageRange = values);
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "What's your preferred match distance?",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text("${_distance.toInt()} km away"),
                      Slider(
                        value: _distance,
                        min: 1,
                        max: 100,
                        divisions: 100,
                        label: "${_distance.toInt()}",
                        onChanged: (value) {
                          setState(() => _distance = value);
                        },
                      ),
                      SwitchListTile(
                        title: const Text("Show profiles with verified identity only?"),
                        secondary: const Icon(Icons.verified, color: Colors.blue),
                        value: _verifiedOnly,
                        onChanged: (val) {
                          setState(() => _verifiedOnly = val);
                        },
                      ),
                      ListTile(
                        title: const Text("Do you prefer people who speak a particular language?"),
                        subtitle: const Text("Select languages"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // TODO: Navigate to language selection screen
                        },
                      ),
                      ListTile(
                        title: const Text("Do you prefer people who follow a particular religion?"),
                        subtitle: const Text("Select religion"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // TODO: Navigate to religion selection screen
                        },
                      ),
                    ],
                  ),
                ),

                // ADVANCED FILTERS TAB
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      const Text(
                        "How tall do you prefer them to be?",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text("${_preferredHeight.toInt()} cm"),
                      Slider(
                        value: _preferredHeight,
                        min: 120,
                        max: 220,
                        divisions: 100,
                        label: "${_preferredHeight.toInt()}",
                        onChanged: (value) {
                          setState(() => _preferredHeight = value);
                        },
                      ),
                      SwitchListTile(
                        title: const Text("Has bio"),
                        value: _hasBio,
                        onChanged: (val) => setState(() => _hasBio = val),
                      ),
                      SwitchListTile(
                        title: const Text("Has voice prompts"),
                        value: _hasVoice,
                        onChanged: (val) => setState(() => _hasVoice = val),
                      ),
                      SwitchListTile(
                        title: const Text("Has video notes"),
                        value: _hasVideo,
                        onChanged: (val) => setState(() => _hasVideo = val),
                      ),
                      const Divider(),
                      const ListTile(title: Text("Intent"), trailing: Icon(Icons.arrow_forward_ios, size: 16)),
                      const ListTile(title: Text("Sexual Orientation"), trailing: Icon(Icons.arrow_forward_ios, size: 16)),
                      const ListTile(title: Text("MBTI Personality type"), trailing: Icon(Icons.arrow_forward_ios, size: 16)),
                      const ListTile(title: Text("Emotional type"), trailing: Icon(Icons.arrow_forward_ios, size: 16)),
                      const ListTile(title: Text("Workout"), trailing: Icon(Icons.arrow_forward_ios, size: 16)),
                      const ListTile(title: Text("Drinking"), trailing: Icon(Icons.arrow_forward_ios, size: 16)),
                      const ListTile(title: Text("Smoking"), trailing: Icon(Icons.arrow_forward_ios, size: 16)),
                      const ListTile(title: Text("Pets"), trailing: Icon(Icons.arrow_forward_ios, size: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Apply Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: save filters & close
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Apply",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
