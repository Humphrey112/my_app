import 'package:flutter/material.dart';
import 'package:my_app/providers/news_provider.dart';
import 'package:provider/provider.dart';

import '../../models/news_model.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key, required this.title});

  final String title;

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<NewsProvider>(context, listen: false);

      switch (widget.title) {
        case 'Tech':
          provider.fetchTechNews();
          break;
        case 'Economy':
          provider.fetchEconomyNews();
          break;
        case 'Sport':
          provider.fetchSportsNews();
          break;
        case 'Health':
          provider.fetchHealthNews();
          break;
        case 'Fun':
          provider.fetchFunNews();
          break;
        case 'Science':
          provider.fetchScienceNews();
          break;
        case 'General':
          provider.fetchGeneralNews();
          break;
        case 'Music':
          provider.fetchMusicNews();
          break;
        case 'Art':
          provider.fetchArtNews();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "${widget.title} News",
          style: const TextStyle(
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
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Article> articles;

          switch (widget.title) {
            case 'Tech':
              articles = provider.techNewsList;
              break;
            case 'Economy':
              articles = provider.economyNewsList;
              break;
            case 'Sport':
              articles = provider.sportsNewsList;
              break;
            case 'Health':
              articles = provider.healthNewsList;
              break;
            case 'Fun':
              articles = provider.funNewsList;
              break;
            case 'Science':
              articles = provider.scienceNewsList;
              break;
            case 'General':
              articles = provider.generalNewsList;
              break;
            case 'Music':
              articles = provider.musicNewsList;
              break;
            case 'Art':
              articles = provider.artNewsList;
              break;
            default:
              articles = [];
          }

          if (articles.isEmpty) {
            return const Center(child: Text("No news available"));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // HEADER IMAGE
                Stack(
                  children: [
                    (articles[0].urlToImage?.isEmpty ?? false)
                        ? const Icon(Icons.broken_image, size: 110)
                        : Image.network(
                            articles[0].urlToImage ?? '',
                            width: double.infinity,
                            height: 260,
                            fit: BoxFit.cover,
                          ),
                    Container(
                      height: 260,
                      color: const Color.fromARGB(24, 33, 149, 243),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 15,
                      right: 15,
                      child: Text(
                        "Latest ${widget.title} News around the world",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // NEWS LIST
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];

                    final hasImage =
                        article.urlToImage != null &&
                        article.urlToImage!.isNotEmpty;

                    return InkWell(
                      onTap: () {},
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
                              child: hasImage
                                  ? Image.network(
                                      article.urlToImage!,
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
                                  : const Icon(Icons.broken_image, size: 110),
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
                                        child: Text(
                                          article.author ?? 'News',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        article.source.name ?? '',
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
