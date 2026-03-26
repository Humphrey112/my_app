import 'package:flutter/material.dart';

import 'auth/loginscreen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": 'assets/work.png',
      "title": "The Home of News",
      "desc":
          "Instead of moving from one place to another, we bring the news to where you are.",
    },
    {
      "image": "assets/micNews.PNG",
      "title": "The Voices of People",
      "desc":
          "A privilege to get firsthand information from the world over.listen to the heartbeat of people.Hear the voices of people",
    },
    {
      "image": "assets/newsPaper.PNG",
      "title": "No need to hold the papers",
      "desc":
          "Get all the news you need. You don't have to continue buyingnthe papers.get it all those news here",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.red],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final data = onboardingData[index];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// IMAGE
                      Image.asset(data["image"]!, height: 200),

                      const SizedBox(height: 40),

                      /// TITLE
                      Text(
                        data["title"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// DESCRIPTION
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          data["desc"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            /// BOTTOM SECTION
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// SKIP
                  currentPage == onboardingData.length - 1
                      ? const SizedBox()
                      : TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Loginscreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                  /// DOTS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                      (index) => GestureDetector(
                        onTap: () {
                          controller.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentPage == index ? 20 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? Colors.blue
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// NEXT
                  currentPage == onboardingData.length - 1
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Loginscreen(),
                              ),
                            );
                          },
                          child: const Text("Get Started"),
                        )
                      : IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
