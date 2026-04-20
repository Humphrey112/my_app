import 'package:flutter/material.dart';
import 'package:my_app/providers/news_provider.dart';
import 'package:provider/provider.dart';

class ArtNewsPage extends StatefulWidget {
  const ArtNewsPage({super.key});

  @override
  State<ArtNewsPage> createState() => _ArtNewsPageState();
}

class _ArtNewsPageState extends State<ArtNewsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).fetchArtNews();
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
          "Art News",
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
                // Header Image
                Stack(
                  children: [
                    Image.asset(
                      'assets/art.png',
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
                        "Latest Art & Culture News around the world",
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
                // The News List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.artNewsList.length,
                  itemBuilder: (context, index) {
                    final article = provider.artNewsList[index];

                    // Handle potential URL issues
                    String imageUrl = article.urlToImage ?? "";
                    if (imageUrl.startsWith("//")) {
                      imageUrl = "https:$imageUrl";
                    }
                    final bool hasValidUrl =
                        imageUrl.isNotEmpty && imageUrl.startsWith('http');
                    
                    return InkWell(
                      onTap: () {
                        print("You pressed: ${article.title}");
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
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                        Icons.broken_image,
                                        size: 110,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.broken_image,
                                      size: 110,
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
                                    style: const TextStyle(fontSize: 15),
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
                                          color: Colors.purple,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: const Text(
                                          "ART",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        article.source?.name ?? '',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
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
