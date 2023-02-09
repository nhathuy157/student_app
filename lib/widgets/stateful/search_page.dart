import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:student_app/modules/job/screen/job_result_page.dart';
import 'package:student_app/widgets/stateful/my_search.dart';
import 'package:student_app/widgets/stateless/icon_button_back.dart';

import '../../config/themes/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const historyLength = 5;
  List<String> _searchHistory = [
    "number 1",
    "number 2",
    "number 3",
    "number 4",
    "number 5",
    "number 6",
  ];
  List<String> filteredSearchHistory = [];
  String selectedTerm = "";
  List<String> filterSearchTerms({required String? filter}) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((element) => element == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void initState() {
    searchController = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
    super.initState();
  }

  FloatingSearchBarController? searchController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: AppColors.lightGreen,
        //   leading: IconButtonBack(),

        // ),
        // body:showSearch(context: context, delegate: cu)
        //  FloatingSearchAppBar(
        //   automaticallyImplyBackButton: false,
        //   leadingActions: [IconButtonBack()],
        //   hint: "Nhập từ bạn muốn tìm",
        //   controller: searchController,
        //   actions: [FloatingSearchBarAction.searchToClear()],
        //   onQueryChanged: (query) {
        //     setState(() {
        //       filteredSearchHistory = filterSearchTerms(filter: query);
        //     });
        //   },
        //   onSubmitted: (query) {
        //     setState(() {
        //       addSearchTerm(query);
        //       selectedTerm = query;
        //     });
        //     searchController!.close();
        //   },
        //   body: FloatingSearchBarScrollNotifier(child: Container()),
        //    ),
        );
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class CustomSearch extends MySearchDelegate {
  List<String> listQuery = [
    "number 1",
    "number 2",
    "number 3",
    "number 4",
    "number 5",
    "number 6",
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, "");
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButtonBack();
  }

  @override
  Widget buildResults(BuildContext context) {
    this.close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in listQuery) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            query = matchQuery[index];
            close(context, query);
          },
        );
      },
    );
  }
}
