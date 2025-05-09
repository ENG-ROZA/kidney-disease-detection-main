import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/models/articles_model.dart';
import 'package:graduation_project/modules/screens/articles/articles_details.dart';
import 'package:graduation_project/modules/screens/articles/articles_search.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/widgets/shimmer_effects.dart';
import 'package:graduation_project/widgets/welcome/article_welcome.dart';
import '../../../shared/network/remote/api_manager.dart';

class ArticlesScreen extends StatefulWidget {
  static const String routeName = 'articles';
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late Future<ArticlesResponse> _articlesFuture;
  bool showOverlay = true;
  void hideOverlay() {
    setState(() {
      showOverlay = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _articlesFuture = ApiManager.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Stack(children: [
      Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Articles",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: screenHeight * 0.025,
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: ArticlesSearch(),
                      );
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        size: screenHeight * 0.025,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      hintText: 'Search for articles',
                      hintStyle: GoogleFonts.crimsonText(
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.normal,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Latest Articles",
                    style: GoogleFonts.crimsonText(
                      fontSize: screenHeight * 0.022,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  FutureBuilder(
                    future: _articlesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return latestArticleShimmerEffect();
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      final articles = snapshot.data?.results ?? [];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ArticlesDetails.routeName,
                            arguments: articles[0].id,
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: screenHeight * 0.2,
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  articles[0].image?.url ?? "",
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(screenWidth * 0.04),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      articles[0].title ?? "",
                                      style: GoogleFonts.merriweather(
                                        fontSize: screenHeight * 0.025,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      articles[0]
                                          .createdAt
                                          .toString()
                                          .substring(0, 10),
                                      style: GoogleFonts.merriweather(
                                        fontSize: screenHeight * 0.016,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                      ),
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
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    "All Articles",
                    style: GoogleFonts.crimsonText(
                      fontSize: screenHeight * 0.022,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Expanded(
                    child: FutureBuilder(
                      future: _articlesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return baseArticleShimmerEffect();
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        final articles = snapshot.data?.results ?? [];
                        return ListView.builder(
                          itemBuilder: (context, index) => articlesItem(
                            context,
                            articleId: articles[index].id ?? "",
                            articleImage: articles[index].image?.url ?? "",
                            articleTitle: articles[index].title ?? "",
                            articleDate: articles[index]
                                .createdAt
                                .toString()
                                .substring(0, 10),
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          ),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: articles.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      if (showOverlay)
        Positioned.fill(
          child: OpacityArticleWelcomScreen(onClose: hideOverlay),
        ),
    ]);
  }

  Widget articlesItem(
    BuildContext context, {
    required String articleImage,
    required String articleTitle,
    required String articleId,
    required String articleDate,
    required double screenHeight,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.3,
            height: screenHeight * 0.12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                articleImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenHeight * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    articleTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.crimsonText(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: screenHeight * 0.018,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        articleDate,
                        style: GoogleFonts.crimsonText(
                          color: const Color(0xFF8E8E93),
                          fontSize: screenHeight * 0.016,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            ArticlesDetails.routeName,
                            arguments: articleId,
                          );
                        },
                        child: Text(
                          "Read now",
                          style: GoogleFonts.crimsonText(
                            color: const Color(0xFF2F79E8),
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
