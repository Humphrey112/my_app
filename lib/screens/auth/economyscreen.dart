import 'package:flutter/material.dart';

class NewsArticle {
  final String imageUrl;
  final String title;
  final String timestamp;

  NewsArticle({
    required this.imageUrl,
    required this.title,
    required this.timestamp,
  });
}

class EconomyNewsPage extends StatelessWidget {
  const EconomyNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // I have added all 10 images here so they all show up in your list
    final List<NewsArticle> articles = [
      NewsArticle(imageUrl: 'assets/img1.png', title: "Oltre 25mila imprese, una crescita del 185% in meno di dieci anni...", timestamp: "2026-02-15T17:33:09Z"),
      NewsArticle(imageUrl: 'assets/img2.png', title: "In this week's episode of the Equity podcast, Glean CEO Arvind Jain...", timestamp: "2026-02-15T17:31:36Z"),
      NewsArticle(imageUrl: 'assets/img3.png', title: "Bring fast, reliable Wi-Fi 7 to your business or connected home...", timestamp: "2026-02-15T17:30:24Z"),
      NewsArticle(imageUrl: 'assets/img4.png', title: "SAG-AFTRA is not real happy about this development from a newer...", timestamp: "2026-02-15T17:28:10Z"),
      NewsArticle(imageUrl: 'assets/img5.png', title: "New economic shifts in the tech sector are driving massive changes...", timestamp: "2026-02-15T17:25:00Z"),
      NewsArticle(imageUrl: 'assets/img6.png', title: "How startup culture is surviving the latest interest rate hikes...", timestamp: "2026-02-15T17:20:00Z"),
      NewsArticle(imageUrl: 'assets/img7.png', title: "The future of remote work and its impact on commercial real estate...", timestamp: "2026-02-15T17:15:00Z"),
      NewsArticle(imageUrl: 'assets/img8.png', title: "Global markets react to the latest trade agreements signed today...", timestamp: "2026-02-15T17:10:00Z"),
      NewsArticle(imageUrl: 'assets/img9.png', title: "Venture capital trends to watch for in the upcoming fiscal quarter...", timestamp: "2026-02-15T17:05:00Z"),
      NewsArticle(imageUrl: 'assets/img10.png', title: "Sustainability in manufacturing: Why green energy is the new gold...", timestamp: "2026-02-15T17:00:00Z"),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Economy News",
          style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Stack(
              children: [
                Image.asset('assets/img1.jpeg', width: double.infinity, height: 260, fit: BoxFit.cover),
                Container(height: 260, color: const Color.fromARGB(24, 33, 149, 243)),
                const Positioned(
                  bottom: 20, left: 15, right: 15,
                  child: Text(
                    "Come sta andando l'economia dei content creator?",
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // The News List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                // InkWell makes the item "Pressable"
                return InkWell(
                  onTap: () {
                    // This is where the code goes when you press it
                    print("You pressed: ${article.title}");
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(article.imageUrl, width: 110, height: 110, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(article.title, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15)),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(6)),
                                    child: const Text("ECONOMY", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                                  Text(article.timestamp, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}