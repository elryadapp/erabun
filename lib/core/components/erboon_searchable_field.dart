import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/data/models/remote_data_models/auth_models/cities_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import'package:sizer/sizer.dart';
class ErboonSearchableField extends StatelessWidget {
  final String hint;
  final Icon prefixIcon;
  final List<CityModel> suggestions;
  final TextEditingController controller;
  const ErboonSearchableField({Key? key, required this.hint, required this.prefixIcon, required this.suggestions, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchField(
      
          controller:controller ,
          suggestions: suggestions
              .map((e) => SearchFieldListItem(e.name!))
              .toList(),
          textInputAction: TextInputAction.next,
          hint: hint,
          hasOverlay: false,
          searchStyle: 
        GoogleFonts.cairo(
          
          color: AppUi.colors.secondryColor.withOpacity(.5),
          fontSize:11.sp
        ),
      
          searchInputDecoration: InputDecoration(
             
        hintStyle:  GoogleFonts.cairo(
          
          color: AppUi.colors.secondryColor.withOpacity(.5),
          fontSize:11.sp
        ),
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 10, vertical: Constants.getwidth(context) * 0.0153),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: AppUi.colors.mainColor,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: AppUi.colors.mainColor,
                )),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppUi.colors.failureRed),
            ),
          ),
          itemHeight: 50,
        );
  }
}
