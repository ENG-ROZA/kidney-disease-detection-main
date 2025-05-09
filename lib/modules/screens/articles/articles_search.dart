import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/modules/screens/articles/articles_screen.dart';
import 'package:graduation_project/shared/network/remote/api_manager.dart';
import 'package:graduation_project/shared/utils/colors.dart';

class ArticlesSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0.7,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.crimsonTextTextTheme(
        theme.textTheme,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.transparent,
        filled: true,
        hintStyle: GoogleFonts.crimsonText(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(
            Icons.clear_sharp,
            size: 22,
            color: Colors.black,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new,
        size: 20,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: ApiManager.getArticlesSearch(query),
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
            final articles = snapshot.data?.results ?? [];
            return articles.isEmpty
                ? Center(
                    child: Text(
                    'No results found',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ))
                : ListView.builder(
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
