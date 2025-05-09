import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as flutter_image;
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/models/article_details.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/shared/utils/colors.dart';

class ArticlesDetails extends StatefulWidget {
  static const String routeName = 'ArticlesDetails';
  const ArticlesDetails({super.key});

  @override
  State<ArticlesDetails> createState() => _ArticlesDetailsState();
}

class _ArticlesDetailsState extends State<ArticlesDetails> {
  late String articleId;
  late Future<ArticleDetailsResponse> _articlesDetailsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get article ID from navigation arguments
    articleId = ModalRoute.of(context)?.settings.arguments as String;
    _articlesDetailsFuture = ApiManager.getArticlesDetails(articleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
             surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
          title: Text(
            "Articles Details",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
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
        ),
        body: FutureBuilder(
          future: _articlesDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
                strokeCap: StrokeCap.round,
                strokeWidth: 6,
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.hasData && snapshot.data?.article == null) {
              return const Center(child: Text('Article not found'));
            }
            final article = snapshot.data!.article;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      flutter_image.Image.network(
                        article.image.url,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(article.title,
                                style: GoogleFonts.merriweather(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                )),
                            Text(article.createdAt.substring(0, 10),
                                style: GoogleFonts.merriweather(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 10,
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          article.content,
                          style: GoogleFonts.crimsonText(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
