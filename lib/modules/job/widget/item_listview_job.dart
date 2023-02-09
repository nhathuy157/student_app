// ignore_for_file: avoid_unnecessary_containers

/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'package:flutter/material.dart';
import 'package:student_app/config/string/string_job.dart';
import 'package:student_app/modules/job/screen/job_details_page.dart';
import 'package:student_app/service/action/job/job_details_action.dart';
import 'package:student_app/widgets/stateless/image_found.dart';

import '../../../config/routes/routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../controller/job_fliter.dart';

class ItemListViewJob extends StatefulWidget {
  final String textNameJob;
  final String textSalary;
  final String textAddress;
  final String textNatural;
  final String img;
  String idJob;

  ItemListViewJob({
    Key? key,
    required this.textNameJob,
    required this.textAddress,
    required this.textNatural,
    required this.textSalary,
    required this.img,
    required this.idJob,
  }) : super(key: key);

  @override
  State<ItemListViewJob> createState() => _ItemListViewJobState();
}

class _ItemListViewJobState extends State<ItemListViewJob> {
  bool changeIcon = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        // Navigator.of(context).pushNamed(Routes.jobDetailsPage);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailsPage(idJob: widget.idJob),
          ),
        );
      }),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: const EdgeInsets.all(4),
          width: 352,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.mainColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  color: Colors.black26, offset: Offset(3, 3), blurRadius: 3)
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 27,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ImageNotFound(imageLink: widget.img),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 63,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (() {
                          setState(() {
                            changeIcon = !changeIcon;
                          });
                        }),
                        child: Icon(
                          changeIcon ? Icons.star : Icons.star_border_outlined,
                          size: 34,
                          color: AppColors.orangeryYellow,
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.textNameJob,
                              style: AppTextStyles.h5.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColorBold),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.textSalary,
                                style: AppTextStyles.h5.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                          ),
                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   child: Text(widget.textNatural,
                          //       style: AppTextStyles.h5),
                          // ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.textAddress,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.h5),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text('1/05/2022',
                                style: AppTextStyles.h5),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
