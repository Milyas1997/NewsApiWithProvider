import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapiwithprovider/repository/get_headline.dart';
import 'package:newsapiwithprovider/view/category_and_detail_screen/category_detail_screen.dart';

class GeneralNewsScreen extends StatefulWidget {
  final GetNewsApi value;
  final double height;
  final double width;
  final DateFormat format;

  const GeneralNewsScreen({
    super.key,
    required this.value,
    required this.height,
    required this.width,
    required this.format,
  });

  @override
  State<GeneralNewsScreen> createState() => _GeneralNewsScreenState();
}

class _GeneralNewsScreenState extends State<GeneralNewsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.value.categoryChanged!.articles!.length,
        itemBuilder: (context, index) {
          DateTime dateTime = DateTime.parse(widget
              .value.categoryChanged!.articles![index].publishedAt
              .toString());

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryScreenDetail(
                          index: index,
                          value: widget.value,
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      height: widget.height * 0.18,
                      width: widget.width * 0.3,
                      widget.value.categoryChanged!.articles![index].urlToImage
                          .toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: widget.height * 0.18,
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
                            widget.value.categoryChanged!.articles![index].title
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
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                widget.value.categoryChanged!.articles![index]
                                    .source!.name
                                    .toString(),
                                softWrap: false,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                widget.format.format(dateTime).toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.red,
                            thickness: 2.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

          ;
        },
      ),
    );
  }
}
