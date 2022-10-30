import 'dart:io';

import 'package:arboon/blocs/examination_cubit/examination_cubit.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:sizer/sizer.dart';

class PdfViewScreen extends StatefulWidget {
  final File file;
  const PdfViewScreen({Key? key, required this.file}) : super(key: key);

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExaminationCubit, ExaminationState>(
      builder: (context, state) {
        return SizedBox(
          height: Constants.getHeight(context),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
slivers: [
  SliverToBoxAdapter(child:  Padding(
                      padding: EdgeInsets.all(2.h),
                child: Row(
                  children: [
                     InkWell(
                      onTap: () {
                        ExaminationCubit.get(context).changePdfViewStatus(0,null);
                      },
                      child: Icon(
                        IconBroken.Close_Square,
                        color: AppUi.colors.splashColor,
                        size: 4.h,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {

                        ExaminationCubit.get(context).reportFilesList.remove(widget.file);
                                              ExaminationCubit.get(context).changePdfViewStatus(0,null);

                      },
                      child: Icon(
                        IconBroken.Delete,
                        color: AppUi.colors.splashColor,
                        size: 4.h,
                      ),
                    ),
                  ],
                ),
              ),)
              ,SliverToBoxAdapter(child:  SizedBox(
                height: Constants.getHeight(context) * .8,
                child: Center(
                  child: PdfView(path: widget.file.path),
                ),
              ),)
],
          ),
        ) ;
      
      },
    );
  }
}
