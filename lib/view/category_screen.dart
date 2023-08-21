import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../repository/get_headline.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final format = DateFormat('MMM dd,yyyy');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final categoryprovider =
            Provider.of<GetNewsApi>(context, listen: false);

        categoryprovider.getCategoryNews(categoryprovider.selectedCategory);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Consumer<GetNewsApi>(
            builder: (context, value, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: height * 0.060,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.categoriesList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              value.selectedCategory = value.getChangeCategory(
                                value.categoriesList[index].toString(),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Container(
                                padding: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color: value.selectedCategory ==
                                          value.categoriesList[index]
                                      ? Colors.blue
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Center(
                                    child: Text(
                                      value.categoriesList[index],
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: value.catobj!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(
                          value.catobj!.articles![index].publishedAt.toString(),
                        );
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  height: height * 0.18,
                                  width: width * 0.3,
                                  value.catobj!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: height * 0.18,
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        value.catobj!.articles![index].title
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            value.catobj!.articles![index]
                                                .source!.name
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            format.format(dateTime).toString(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
