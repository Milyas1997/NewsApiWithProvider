import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapiwithprovider/repository/get_headline.dart';
import 'package:newsapiwithprovider/view/category_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { arynews, bbcnews, independent, alJazerra, retures, cnn }

class _HomeScreenState extends State<HomeScreen> {
  final format = DateFormat('MMM dd,yyyy');

  FilterList? selectedMenu;

  String name = 'bbc-news';

  List categoriesList = [
    'General',
    'Health',
    'Sports',
    'Entertainment',
    'Business',
    'Technology'
  ];
  String selectedCategory = 'General';
  List prolist = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final categoryprovider = Provider.of<GetNewsApi>(context, listen: false);
      categoryprovider.getAllHeadline();
      categoryprovider.getHeadline(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            onSelected: (FilterList item) {
              if (FilterList.bbcnews.name == item.name) {
                name = 'bbc-news';
              }
              if (FilterList.arynews.name == item.name) {
                name = 'ary-news';
              }
              if (FilterList.cnn.name == item.name) {
                name = "cnn";
              }

              if (FilterList.alJazerra.name == item.name) {
                name = 'al-jazeera-english';
              }
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              const PopupMenuItem(
                value: FilterList.bbcnews,
                child: Text("BBC news"),
              ),
              const PopupMenuItem(
                value: FilterList.arynews,
                child: Text("Ary news"),
              ),
              const PopupMenuItem(
                value: FilterList.alJazerra,
                child: Text("Aljazerra news"),
              ),
              const PopupMenuItem(
                value: FilterList.cnn,
                child: Text("Cnn news"),
              ),
            ],
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoryScreen()),
            );
          },
          icon: Image.asset(
            'assets/images/category_icon.png',
            height: 25,
            width: 25,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'NEWS',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Consumer<GetNewsApi>(
            builder: (context, value, child) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.catobj!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(value
                              .catobj!.articles![index].publishedAt
                              .toString());
                          return SizedBox(
                            child: Stack(
                              children: [
                                Container(
                                  height: height * 0.5,
                                  width: width * 0.9,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      value.catobj!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  left: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      height: height * 0.16,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                                format
                                                    .format(dateTime)
                                                    .toString(),
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
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: value.catobj!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(value
                            .catobj!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
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
