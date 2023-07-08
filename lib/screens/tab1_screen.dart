import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:newsapp/theme/theme.dart';
import 'package:newsapp/widgets/lista_news.dart';
import 'package:newsapp/services/news_service.dart';

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({Key? key}) : super(key: key);

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: (newsService.headLines.isEmpty)
          ? Center(
              child: CircularProgressIndicator(
                color: myTheme.colorScheme.secondary,
              ),
            )
          : ListaNews(newsService.headLines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
