import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../model/categories_news_model.dart';
import '../model/news_model.dart';

class GetNewsApi with ChangeNotifier {
  String selectedCategory = 'General';
  CategoryNewsModel? catobj;

  List categoriesList = [
    'General',
    'Health',
    'Sports',
    'Entertainment',
    'Business',
    'Technology'
  ];

  String getChangeCategory(String categoryName) {
    selectedCategory = categoryName;
    notifyListeners();
    return selectedCategory;
  }

  Future<NewsModel> getHeadline(String channelName) async {
    String headlineUrl =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=e86c18ae5c54483aa37342f4e5972d24';
    final Response response = await http.get(Uri.parse(headlineUrl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      debugPrint('THE RESPONSE COME ARE:');
      debugPrint(response.body);
      NewsModel newsModel = NewsModel.fromJson(body);
      notifyListeners();
      return newsModel;
    }
    throw Exception('Error occure within getHeadlineMethod');
  }

  Future<CategoryNewsModel> getCategoryNews(String category) async {
    String categoryUrl =
        'https://newsapi.org/v2/everything?q=$category&apiKey=e86c18ae5c54483aa37342f4e5972d24';
    final Response response = await http.get(Uri.parse(categoryUrl));
    if (response.statusCode == 200) {
      debugPrint('API GET ARE:: ${response.body}');
      final body = jsonDecode(response.body);
      var categoryNews = CategoryNewsModel.fromJson(body);
      catobj = categoryNews;
      notifyListeners();

      return categoryNews;
    }
    throw Exception('Error occure within getCategory method');
  }

  Future<CategoryNewsModel> getAllHeadline() async {
    var headlineUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=e86c18ae5c54483aa37342f4e5972d24';

    final Response response = await http.get(Uri.parse(headlineUrl));
    if (response.statusCode == 200) {
      debugPrint('API GET ARE:: ${response.body}');
      final body = jsonDecode(response.body);
      var categoryNews = CategoryNewsModel.fromJson(body);
      catobj = categoryNews;
      notifyListeners();

      return categoryNews;
    }
    throw Exception('Error occure within getCategory method');
  }
}
