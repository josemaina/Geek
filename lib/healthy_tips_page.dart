import 'package:flutter/material.dart';

class HealthyTipsPage extends StatefulWidget {
  @override
  _HealthyTipsPageState createState() => _HealthyTipsPageState();
}

class _HealthyTipsPageState extends State<HealthyTipsPage> {
  final List<Map<String, String>> healthyTips = [
    {'title': 'Stay Hydrated', 'content': 'Drink at least 8 glasses of water daily to keep your body hydrated.', 'imageUrl': 'https://source.unsplash.com/featured/?water,health'},
    {'title': 'Eat More Vegetables', 'content': 'Include green leafy vegetables in your diet for better nutrition.', 'imageUrl': 'https://source.unsplash.com/featured/?vegetables,healthy'},
    {'title': 'Exercise Regularly', 'content': 'Aim for at least 30 minutes of moderate exercise daily.', 'imageUrl': 'https://source.unsplash.com/featured/?exercise,fitness'},
    {'title': 'Get Enough Sleep', 'content': 'Aim for 7-9 hours of sleep every night for better health.', 'imageUrl': 'https://source.unsplash.com/featured/?sleep,health'},
    {'title': 'Reduce Sugar Intake', 'content': 'Limit sugar consumption to prevent diabetes and other health issues.', 'imageUrl': 'https://source.unsplash.com/featured/?sugar,health'},
    {'title': 'Practice Mindfulness', 'content': 'Take time to relax and practice mindfulness for mental well-being.', 'imageUrl': 'https://source.unsplash.com/featured/?meditation,relaxation'},
    {'title': 'Maintain Good Posture', 'content': 'Keep your back straight while sitting to avoid spinal issues.', 'imageUrl': 'https://source.unsplash.com/featured/?posture,ergonomics'},
    {'title': 'Wash Your Hands Regularly', 'content': 'Good hygiene prevents infections and promotes health.', 'imageUrl': 'https://source.unsplash.com/featured/?hygiene,health'},
    {'title': 'Avoid Processed Foods', 'content': 'Eat fresh foods to maintain overall well-being.', 'imageUrl': 'https://source.unsplash.com/featured/?healthyfood,organic'},
    {'title': 'Stay Active', 'content': 'Move around every hour to keep your body active.', 'imageUrl': 'https://source.unsplash.com/featured/?active,lifestyle'}
  ];

  List<Map<String, String>> filteredTips = [];
  Set<String> favoriteTips = {};

  @override
  void initState() {
    super.initState();
    filteredTips = healthyTips;
  }

  void _filterTips(String query) {
    setState(() {
      filteredTips = healthyTips.where((tip) => tip['title']!.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void _toggleFavorite(String title) {
    setState(() {
      if (favoriteTips.contains(title)) {
        favoriteTips.remove(title);
      } else {
        favoriteTips.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(title: Text('Healthy Tips')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('See Your Favorite Tips'),
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    padding: EdgeInsets.all(16.0),
                    child: ListView(
                      children: favoriteTips.isNotEmpty
                          ? favoriteTips.map((title) {
                              final tip = healthyTips.firstWhere((t) => t['title'] == title);
                              return ListTile(
                                leading: Image.network(tip['imageUrl']!, width: 50, height: 50, fit: BoxFit.cover),
                                title: Text(tip['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text(tip['content']!),
                              );
                            }).toList()
                          : [Text('No favorite tips selected.', textAlign: TextAlign.center)],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: _filterTips,
              decoration: InputDecoration(
                labelText: 'Search Tips',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTips.length,
                itemBuilder: (context, index) {
                  final tip = filteredTips[index];
                  final isFavorite = favoriteTips.contains(tip['title']);
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    child: ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(tip['title']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.grey),
                            onPressed: () => _toggleFavorite(tip['title']!),
                          ),
                        ],
                      ),
                      leading: Image.network(tip['imageUrl']!, width: 50, height: 50, fit: BoxFit.cover),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(tip['content']!, style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back to Home'),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), textStyle: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
