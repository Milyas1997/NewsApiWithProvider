import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapiwithprovider/view/category_and_detail_screen/category_screen.dart';
import 'package:provider/provider.dart';

import '../../repository/get_headline.dart';

class CategoryScreenDetail extends StatefulWidget {
  final int index;
  final GetNewsApi value;

  const CategoryScreenDetail(
      {super.key, required this.index, required this.value});

  @override
  State<CategoryScreenDetail> createState() => _CategoryScreenDetailState();
}

class _CategoryScreenDetailState extends State<CategoryScreenDetail> {
  final format = DateFormat('MMM dd,yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Consumer<GetNewsApi>(
          builder: (contex, value, child) {
            DateTime dateTime = DateTime.parse(value
                .categoryChanged!.articles![widget.index].publishedAt
                .toString());
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value.categoryChanged!.articles![widget.index].title
                        .toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      value.categoryChanged!.articles![widget.index].urlToImage
                          .toString(),
                      height: height * 0.4,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        format.format(dateTime),
                        style: GoogleFonts.poppins(),
                      ),
                      Text(
                        value.categoryChanged!.articles![widget.index].source!
                            .name
                            .toString(),
                        style: GoogleFonts.poppins(color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white38),
                      child: SingleChildScrollView(
                        child: Text(
                          value.categoryChanged!.articles![widget.index].content
                              .toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.red,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
