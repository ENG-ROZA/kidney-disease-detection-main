import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/modules/screens/articles/articles_details.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/shared/utils/colors.dart';

class ArticlesSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return theme.copyWith(
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0.7,
        iconTheme: IconThemeData(
          color: Colors.black54,
          size: screenHeight * 0.025, // Responsive icon size
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.crimsonTextTextTheme(theme.textTheme),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.transparent,
        filled: true,
        hintStyle: GoogleFonts.crimsonText(
          fontSize: screenHeight * 0.02, // Dynamic font size
          fontWeight: FontWeight.normal,
          color: Colors.black.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015, // Responsive padding
          horizontal: screenWidth * 0.04,
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(
          Icons.clear_sharp,
          size: screenHeight * 0.025, // Responsive icon size
          color: Colors.black,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        size: screenHeight * 0.022, // Responsive icon size
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
          future: ApiManager.getArticlesSearch(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  strokeCap: StrokeCap.round,
                  strokeWidth: 6,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final articles = snapshot.data?.results ?? [];
            return articles.isEmpty
                ? Center(
                    child: Text(
                      'No results found',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: screenHeight * 0.025, // Dynamic font size
                      ),
                    ),
                  )
                : ListView.builder(
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
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

// Move this to articles_item.dart (or keep inline if preferred)
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
    padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.3, // Responsive width
          height: screenHeight * 0.15, // Responsive height
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(articleImage, fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
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
                    fontSize: screenHeight * 0.018, // Dynamic font size
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
                        fontSize: screenHeight * 0.016, // Dynamic font size
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
                          fontSize: screenHeight * 0.018, // Dynamic font size
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