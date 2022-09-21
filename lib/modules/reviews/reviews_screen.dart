import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/core/components/animated_commponent.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/modules/reviews/components/review_card.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getCenterReviews(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit=ProfileCubit.get(context);
        return Scaffold(
          appBar: EarbunAppbar(
            context,
            titleText: 'تقيمات العملاء',
            actions: const [],
          ),
          body: BuildCondition(
            condition: state is GetReviewsloadingState,
            builder: (context)=>AppUtil.appLoader(),
            fallback: (context) {
              return cubit.reviewsList.isEmpty? 
               Column(
                                 children: [
                                
                                   AppUtil.emptyLottie(height: 40.h),
                                   const AppText('لا يوجد لديك تقييمات حاليا')
                                 ],
                               )
              :
              ErboonSlideAnimation(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AppUtil.appRater(double.parse(
                                '${cubit.profileDataModel?.rate??'0'}')),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: AppText(
                                '${cubit.profileDataModel?.rate??'0'}',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              IconBroken.User,
                              color: AppUi.colors.mainColor,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            AppText(
                              '${cubit.profileDataModel?.reviewsNum??'0'} تقييم',
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h,),
                        Column(
                          children: List.generate(
                              10,
                              (index) => Padding(
                                    padding: EdgeInsets.only(bottom: 2.h),
                                    child: const ReviewCard(),
                                  )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        );
      },
    );
  }
}
