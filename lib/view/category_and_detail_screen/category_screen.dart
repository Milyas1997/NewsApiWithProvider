import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../repository/get_headline.dart';
import '../widget/general_news_screen.dart';

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
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: height * 0.060,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.categoriesList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              value.selectedCategory =
                                  value.getChangeCategoryNames(
                                value.categoriesList[index],
                              );
                              value.getCategoryNews(value.selectedCategory);
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
                  value.categoryChanged == null
                      ? const SpinKitCircle(
                          color: Colors.blue,
                          size: 50,
                        )
                      : GeneralNewsScreen(
                          value: value,
                          height: height,
                          width: width,
                          format: format,
                        )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
