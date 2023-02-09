// ignore_for_file: must_be_immutable

import 'package:flutter/src/widgets/framework.dart';

import '../../controller/utility_controller.dart';
import 'catch_error_page.dart';
import 'loading.dart';

class LoadingPageCatchError extends StatelessWidget {
  Widget widget;
  bool isLoading;
  bool isError;
  LoadingPageCatchError(
      {Key? key,
      required this.isLoading,
      required this.isError,
      required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : isError
            ? CatchErrorPage(
                haveConnect: UtilityController.instance.haveConnect,
              )
            : widget;
  }
}
