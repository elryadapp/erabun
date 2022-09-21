import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                         

      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppUi.colors.subTitleColor.withOpacity(.1),
      ),
      child: Column(

        children: [
          Row(

            children: [
              CircleAvatar(
                radius: 4.h,
                backgroundImage: AssetImage(AppUi.assets.fakeUser),
              ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText('السيد احمد'),
                  Row(
                    children: [
                      AppUtil.appRater(3),
                      SizedBox(
                        width: 3.w,
                      ),
                      const AppText(
                        '3.0',
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  )
                ],
              )
            ],
          ),

          Padding(
            padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.w),
            child: AppText('هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام "هنا يوجد محتوى نصي، هنا يوجد محتوى نصي" فتجعلها تبدو (أي الأحرف) وكأنها نص مقروء. العديد من برامح النشر المكتبي وبرامح تحرير صفحات الويب تستخدم لوريم إيبسوم بشكل إفتراضي كنموذج عن النص',
            maxLines: 4,height: 1.6,

            fontSize: 1.7.h,
            textAlign: TextAlign.justify,
            color: AppUi.colors.subTitleColor.withOpacity(.6),
            ),
          )
        ],
      ),
    );
  }
}
