import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/models/news_models.dart';

const String _urlNews = 'https://newsapi.org/v2';
const String _apiKey = 'bc79e6bdd02b4bf9bebccd7b4e58d193';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];
  String _selectedCategory = 'general';

  bool _isLoading = true;

  List<CategoryModel> categories = [
    CategoryModel(FontAwesomeIcons.addressCard, 'general'),
    CategoryModel(FontAwesomeIcons.building, 'business'),
    CategoryModel(FontAwesomeIcons.tv, 'entertainment'),
    CategoryModel(FontAwesomeIcons.headSideVirus, 'health'),
    CategoryModel(FontAwesomeIcons.vials, 'science'),
    CategoryModel(FontAwesomeIcons.volleyball, 'sports'),
    CategoryModel(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadLines();
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }
    getArticlesByCategory(selectedCategory);
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    _selectedCategory = valor;
    _isLoading = true;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get articlesByCategory {
    return categoryArticles[selectedCategory]!;
  }

  getTopHeadLines() async {
    const url = '$_urlNews/top-headlines?country=us&apiKey=$_apiKey';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = NewsResponse.fromRawJson(resp.body);

    headLines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    final url = '$_urlNews/top-headlines?country=us&apiKey=$_apiKey&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = NewsResponse.fromRawJson(resp.body);
    categoryArticles[category]!.addAll(newsResponse.articles);
    _isLoading = false;
    notifyListeners();
  }
}
