import 'dart:io';
import 'package:arboon/blocs/examination_cubit/examination_cubit.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/components/app_text_form_field.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ReportImagesView extends StatelessWidget {
  final List currentList;
  final bool? isEditied;
  final TextEditingController insideReportConroller;
  final Function() onTap;
  const ReportImagesView({
    Key? key,
    required this.currentList,
    required this.insideReportConroller,
    required this.onTap,
    this.isEditied = true, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExaminationCubit, ExaminationState>(
      builder: (context, state) {
        var cubit = ExaminationCubit.get(context);
        return Column(
          children: [
            AppTextFormFeild(
              isEnable: isEditied,
              controller: insideReportConroller,
              validation: true,
              hint: 'اختر الصور من المعرض',
              onTapSuffixIcon: onTap,
              suffixIcon: Icon(
                IconBroken.Image,
                size: 6.w,
                color: AppUi.colors.subTitleColor.withOpacity(.5),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: currentList.isNotEmpty ? 3.h : 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            var file = isEditied!
                                ? File(currentList[index].path)
                                : File('');
                            AppUtil.appDialoge(
                                context: context,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            IconBroken.Close_Square,
                                            color: AppUi.colors.mainColor,
                                          )),
                                      const Spacer(),
                                      if (isEditied!)
                                        InkWell(
                                            onTap: () {
                                              currentList
                                                  .remove(currentList[index]);
                                              Navigator.pop(context);
                                              cubit.changeState();
                                            },
                                            child: Icon(
                                              IconBroken.Delete,
                                              color: AppUi.colors.failureRed,
                                            )),
                                    ],
                                  ),
                                ),
                                content: isEditied!
                                    ? Image.file(
                                        file,
                                      )
                                    : AppUtil.appCachedImage(
                                      width: Constants.getwidth(context)*.9,
                                      height: Constants.getHeight(context)*.5,
                                    imgUrl: AppUi.assets.networkUrlImgBase +
                                        currentList[index])
                                            
                                            );
                          },
                          child: Row(
                            children: [
                              Icon(IconBroken.Image,
                                  color: AppUi.colors.splashColor),
                              SizedBox(
                                width: 2.w,
                              ),
                              AppText(isEditied!
                                  ? currentList[index].name
                                  : currentList[index]
                                      .toString()
                                      .split('/')
                                      .last)
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 3.w,
                        ),
                    itemCount: currentList.length),
              ),
            )
          ],
        );
      },
    );
  }
}
