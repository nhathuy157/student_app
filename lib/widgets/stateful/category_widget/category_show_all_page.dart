import 'package:flutter/material.dart';
import 'package:student_app/model/other/category.dart';
import 'package:student_app/widgets/stateful/category_widget/item_category_show_all.dart';

import '../../../config/themes/app_colors.dart';
import '../../../service/size_screen.dart';
import '../../stateless/icon_button_back.dart';
import '../../stateless/no_result.dart';

class CategoryShowAllPage extends StatefulWidget {
  List<Category> categories;
  List<String> categorySelected;
  CategoryShowAllPage(
      {Key? key, required this.categories, required this.categorySelected})
      : super(key: key);

  @override
  State<CategoryShowAllPage> createState() => _CategoryShowAllPageState();
}

class _CategoryShowAllPageState extends State<CategoryShowAllPage> {
  List<Category> listCategory = [];
  List<Category> listCategorySearch = [];
  List<String> selected = [];
  bool loading = true;

  @override
  void initState() {
    selected = widget.categorySelected;
    listCategory = widget.categories;
    super.initState();
  }

  TextEditingController? _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.lightGreen,
        elevation: 4,
        actions: [],
        leading: IconButtonBack(),
        title: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(right: 32, top: 16, bottom: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.mainColor)),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    listCategorySearch = listCategory
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                controller: _textEditingController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        top: 6, bottom: 14, left: 16, right: 16),
                    hintText: 'Nhập tên lĩnh vực cần tìm'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: _textEditingController!.text.isNotEmpty &&
                listCategorySearch.isEmpty
            ? const NoResult()
            : Container(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                color: AppColors.lightGreen,
                height: SizeScreen.sizeHeightFullScreen,
                width: SizeScreen.sizeWidthScreen,
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 12,
                      mainAxisExtent: 36,
                      mainAxisSpacing: 12),
                  itemCount: _textEditingController!.text.isNotEmpty
                      ? listCategorySearch.length
                      : listCategory.length,
                  itemBuilder: (BuildContext ctx, index) {
                    Category category = _textEditingController!.text.isNotEmpty
                        ? listCategorySearch[index]
                        : listCategory[index];

                    return ItemCategoryShowALl(
                        changeColor: selected.contains(category.id),
                        name: category.name,
                        onTap: () {
                          setState(() {
                            if (selected.contains(category.id)) {
                              selected.remove(category.id);
                            } else {
                              selected.add(category.id);
                            }
                          });
                        });
                  },
                ),
              ),
      ),
    );
  }
}
