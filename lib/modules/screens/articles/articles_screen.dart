import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/models/articles_model.dart';
import 'package:graduation_project/modules/screens/articles/articles_details.dart';
import 'package:graduation_project/modules/screens/articles/articles_search.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:graduation_project/widgets/shimmer_effects.dart';

import '../../../shared/network/remote/api_manager.dart';

class ArticlesScreen extends StatefulWidget {
  static const String routeName = 'articles';
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late Future<ArticlesResponse> _articlesFuture;

  @override
  initState() {
    super.initState();
    _articlesFuture = ApiManager.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
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
              fontSize: 20,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onTap: () {
                //! Go To Search Screen
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
                    size: 20,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  hintText: 'Search for articles',
                  hintStyle: GoogleFonts.crimsonText(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.6)),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Latest Articles",
              style: GoogleFonts.crimsonText(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
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
                      Navigator.pushNamed(context, ArticlesDetails.routeName,
                          arguments: articles[0].id);
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Stack(alignment: Alignment.bottomLeft, children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            articles[0].image?.url ?? "",
                            fit: BoxFit.cover,
                            height: 360,
                            width: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(articles[0].title ?? "",
                                  style: GoogleFonts.merriweather(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  )),
                              Text(
                                  articles[0]
                                      .createdAt
                                      .toString()
                                      .substring(0, 10),
                                  style: GoogleFonts.merriweather(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
            const SizedBox(
              height: 15,
            ),
            Text(
              "All Articles",
              style: GoogleFonts.crimsonText(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future: _articlesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: baseArticleShimmerEffect());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final articles = snapshot.data?.results ?? [];
                    return ListView.builder(
                        itemBuilder: (context, index) => articlesItem(context,
                            articleId: articles[index].id ?? "",
                            articleImage: articles[index].image?.url ?? "",
                            articleTitle: articles[index].title ?? "",
                            articleDate: articles[index]
                                .createdAt
                                .toString()
                                .substring(0, 10)),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: articles.length);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget articlesItem(BuildContext context,
    {required String articleImage,
    required String articleTitle,
    required String articleId,
    required String articleDate}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 115,
          height: 105,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(articleImage)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      articleDate,
                      style: GoogleFonts.crimsonText(
                        color: const Color(0xFF8E8E93),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ArticlesDetails.routeName,
                            arguments: articleId);
                      },
                      child: Text(
                        "Read now",
                        style: GoogleFonts.crimsonText(
                          color: const Color(0xFF2F79E8),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
