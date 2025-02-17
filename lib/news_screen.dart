import 'package:flutter/material.dart';
import 'package:newsapp/api/api_manager.dart';
import 'package:newsapp/model/source_response.dart';

class NewsScreen extends StatefulWidget {
  static const String route = 'news screen';
  NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("General"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      drawer: const Drawer(),
      body: FutureBuilder(
        future: ApiManager.getSource(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: const Text("Something went wrong"),
            );
          }

          var data = snapshot.data?.sources ?? [];
          return DefaultTabController(
            initialIndex: currentIndex,
            length: data.length,
            child: Column(
              children: [
                TabBar(
                    onTap: (value) {
                      currentIndex = value;
                      setState(() {});
                    },
                    dividerColor: Colors.transparent,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: const Color(0xff171717),
                    labelColor: const Color(0xff171717),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle:
                        const TextStyle(fontWeight: FontWeight.normal),
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    indicatorWeight: 1,
                    tabs: data.map(
                      (e) {
                        return Tab(
                          text: e.name,
                        );
                      },
                    ).toList()),
                Expanded(
                  child: FutureBuilder(
                    future: ApiManager.getNews(data[currentIndex].id ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: const Text("Something went wrong"),
                        );
                      }

                      var newsData = snapshot.data?.articles ?? [];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(8),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Image.network(
                                        "${newsData[index].urlToImage}",
                                        height: 220,
                                      ),
                                      Text(
                                        "${newsData[index].description}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("By: ${newsData[index].author}"),
                                          Text("${newsData[index].publishedAt}"
                                              .substring(0, 10)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 16,
                                ),
                            itemCount: newsData.length ?? 0),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
