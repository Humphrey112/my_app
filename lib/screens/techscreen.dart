import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

class TechNewsPage extends StatefulWidget {
  const TechNewsPage({super.key});

  @override
  State<TechNewsPage> createState() => _TechNewsPageState();
}

class _TechNewsPageState extends State<TechNewsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch news when the screen loads
    Provider.of<NewsProvider>(context, listen: false).fetchTechNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Tech News",
          style: TextStyle(
            color: Colors.red,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, widget) {
          if (provider.stillFetching) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Banner Image
                Stack(
                  children: [
                    Image.asset(
                      'assets/tech.png',
                      width: double.infinity,
                      height: 260,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 260,
                      color: const Color.fromARGB(24, 33, 149, 243),
                    ),
                    const Positioned(
                      bottom: 20,
                      left: 15,
                      right: 15,
                      child: Text(
                        "Latest Technology & Innovation News",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                
                // Tech News List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.techNewsList.length,
                  itemBuilder: (context, index) {
                    final article = provider.techNewsList[index];

                    // URL Sanitization
                    String imageUrl = article.urlToImage ?? "";
                    if (imageUrl.startsWith("//")) {
                      imageUrl = "https:$imageUrl";
                    }
                    final bool hasValidUrl =
                        imageUrl.isNotEmpty && imageUrl.startsWith('http');

                    return InkWell(
                      onTap: () {
                        // Navigation to detail could go here
                        debugPrint("Opening: ${article.title}");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: hasValidUrl
                                  ? Image.network(
                                      imageUrl,
                                      width: 110,
                                      height: 110,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Image.asset(
                                        'assets/tech.png',
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/tech.png',
                                      width: 110,
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title ?? '',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: const Text(
                                          "TECH",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          article.source?.name ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
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
          );
        },
      ),
    );
  }
}