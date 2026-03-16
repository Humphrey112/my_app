import 'package:flutter/material.dart';

class NewsCategoryScreen extends StatefulWidget {
  const NewsCategoryScreen({super.key});

  @override
  State<NewsCategoryScreen> createState() => _NewsCategoryScreenState();
}

class _NewsCategoryScreenState extends State<NewsCategoryScreen> {
  // 1. THIS TRIGGERS THE MESSAGE AUTOMATICALLY ON LOGIN
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          duration: Duration(seconds: 1), // Disappears in 1 second
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  static final List<CategoryItem> categories = [
    CategoryItem(title: 'Tech', image: 'assets/tech.png', color: Colors.black87),
    CategoryItem(title: 'Economy', image: 'assets/economy.png', color: Colors.brown),
    CategoryItem(title: 'Sport', image: 'assets/sports.png', color: Colors.amber),
    CategoryItem(title: 'Health', image: 'assets/health.png', color: Colors.teal),
    CategoryItem(title: 'Fun', image: 'assets/fun.png', color: Colors.grey),
    CategoryItem(title: 'Science', image: 'assets/science.png', color: Colors.blue),
    CategoryItem(title: 'General', image: 'assets/general.png', color: Colors.green),
    CategoryItem(title: 'Music', image: 'assets/music.png', color: Colors.orange),
    CategoryItem(title: 'Art', image: 'assets/art.png', color: Colors.pink),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Use a Column to separate the scrollable part from the bottom button
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
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const IconButton(
                        icon: Icon(Icons.person_outline),
                        onPressed: null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // This Expanded makes the grid scrollable while keeping the button fixed
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9, 
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: categories[index],
                      onTap: () => _navigateToCategory(categories[index].title),
                    );
                  },
                ),
              ),
            ),

            // 2. FIXED GREEN BUTTON AT THE VERY BOTTOM
        
          ],
        ),
      ),
    );
  }

  void _navigateToCategory(String categoryTitle) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$categoryTitle category selected'),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class CategoryItem {
  final String title;
  final String image;
  final Color color;
  CategoryItem({required this.title, required this.image, required this.color});
}

class CategoryCard extends StatelessWidget {
  final CategoryItem category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(category.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black.withOpacity(0.3), // Darker overlay
          ),
          // 3. CENTERED AND EXTRA BOLD TEXT
          child: Center(
            child: Text(
              category.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900, // Makes it very bold
                shadows: [
                  Shadow(blurRadius: 10, color: Colors.black, offset: Offset(2, 2)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}