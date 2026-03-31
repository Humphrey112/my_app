import 'package:flutter/material.dart';
import 'auth/loginscreen.dart'; 
// Make sure you import this
import 'auth/economyscreen.dart';

class NewsCategoryScreen extends StatefulWidget {
  const NewsCategoryScreen({super.key});

  @override
  State<NewsCategoryScreen> createState() => _NewsCategoryScreenState();
}

class _NewsCategoryScreenState extends State<NewsCategoryScreen> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!', style: TextStyle(fontSize: 16)),
          backgroundColor: Color(0xFF1B8E3D), 
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  final List<Map<String, String>> categories = [
    {'title': 'Tech', 'image': 'assets/tech.png'},
    {'title': 'Economy', 'image': 'assets/economy.png'},
    {'title': 'Sport', 'image': 'assets/sports.png'},
    {'title': 'Health', 'image': 'assets/health.png'},
    {'title': 'Fun', 'image': 'assets/fun.png'},
    {'title': 'Science', 'image': 'assets/science.png'},
    {'title': 'General', 'image': 'assets/general.png'},
    {'title': 'Music', 'image': 'assets/music.png'},
    {'title': 'Art', 'image': 'assets/art.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'News Category',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey[600]),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Loginscreen()),
                          );
                        },
                        child: Icon(Icons.logout, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.65, 
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final String title = categories[index]['title'] ?? 'No Title';
                  final String image = categories[index]['image'] ?? '';
                  
                  return categoryBox(title, image);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryBox(String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (title == 'Economy') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EconomyNewsPage()),
          );
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title category selected'),
              duration: const Duration(milliseconds: 700),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) => const Icon(Icons.error),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black.withOpacity(0.25),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}