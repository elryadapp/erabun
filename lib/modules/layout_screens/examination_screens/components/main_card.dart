import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/data/models/app_components_models/examination_steps_model.dart';
import 'package:flutter/material.dart';
import'package:sizer/sizer.dart';
class MainCard extends StatelessWidget {
  final bool isChecked;
  final ExaminationStepModel e;
  const MainCard({Key? key, required this.isChecked, required this.e}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if(isChecked)
                                  Align(
                                    alignment: AlignmentDirectional.topStart,

                                    child: Padding(
                                      padding:  EdgeInsetsDirectional.only(start: 5.w,),
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        color: AppUi.colors.whiteColor,
                                      ),
                                    ),
                                  ),
                                  Image.asset(e.img),
                                  AppText(
                                    e.title,
                                    color: AppUi.colors.whiteColor,
                                  )
                                ],
                              );
    
  }
}