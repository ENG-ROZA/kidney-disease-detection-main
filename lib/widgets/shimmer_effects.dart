import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget profileShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[300],
        ),
        const SizedBox(height: 12),
        Container(
          width: 50,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    ),
  );
}

Widget homeUserDataShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 50,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget homeDoctorWidgetShimmerEffect(screenHeight, screenWidth) {
  return SizedBox(
    height: screenHeight * 0.6,
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return SizedBox(
            width: screenWidth * 0.4,
            height: screenHeight * 0.05,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.09,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.025,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.025,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget latestArticleShimmerEffect() {
  return SizedBox(
    width: double.infinity,
    height: 200,
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              color: Colors.grey[300],
              height: 200,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 12,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 5),
                Container(
                  width: 80,
                  height: 10,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget baseArticleShimmerEffect() {
  return ListView.separated(
    separatorBuilder: (context, index) => const SizedBox(height: 15),
    itemCount: 3,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 115,
                height: 105,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 180,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            height: 10,
                            color: Colors.grey[300],
                          ),
                          Container(
                            width: 60,
                            height: 12,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget scanResultShimmerEffect(int itemCount) {
  return Expanded(
    child: ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) =>
          const SizedBox(height: 30), // Match original spacing
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20), // Match original horizontal padding
            child: Card(
              color: const Color(0xFFFCFCFC),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    // Image placeholder
                    Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Text placeholders
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 12,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 80,
                          height: 10,
                          color: Colors.grey[300],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget doctorReviewShimmerEffect() {
  return ListView.separated(
    itemCount: 2,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 214,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: 8,
    ),
  );
}

Widget addReviewShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                  shape: BoxShape.rectangle,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 120,
                height: 14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    width: 26,
                    height: 26,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                  shape: BoxShape.rectangle,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget reviewsScreensUserDataShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
