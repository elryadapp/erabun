
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import'package:sizer/sizer.dart';
class AppTextFormFeild extends StatelessWidget {
  final String? hint;
  final Function()? onTapSuffixIcon;
  final bool isFilled;
  final Color? filledColor;
  final bool? isEnable;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String val)?onSubmitted;
  final Function()? onTap;
    final String? Function(String? val)? validator;

  final Function(String s)? onChange;
  final bool obscureText, readOnly, autofocus, validation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines, maxLength;
  final double? radius;
  final String? initialValue;
  final TextAlign? textAlign;
  final dynamic inputFormatters;
  final Color? borderColor;
  const AppTextFormFeild(
      {Key? key,
       this.controller,
      this.isEnable,
      this.filledColor,
       this.hint,
       this.onSubmitted,
      this.borderColor,
       this.textInputType,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.onChange,
      this.maxLines,
      this.textAlign ,
      this.readOnly = false,
      this.autofocus = false,
      this.radius ,
      this.isFilled = false,
      this.maxLength,
      this.validation = false,
      this.inputFormatters, this.validator, this.initialValue, this.onTapSuffixIcon, 
})      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted:onSubmitted?? (value){},
      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText,
    initialValue: initialValue,
      maxLength: maxLength,
      enabled: isEnable ?? true,
      
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChange,
      inputFormatters: inputFormatters,
      validator:validator?? (value) {
              if (value!.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
                              return null;

            },
            
      autofocus: autofocus,
      
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        
        hintText: hint,
        
        hintStyle:  GoogleFonts.cairo(
          
          color: AppUi.colors.secondryColor.withOpacity(.5),
          fontSize:11.sp
        ),
        
        suffixIcon: SizedBox(
          height:suffixIcon!=null? 4.h:0,
          width: suffixIcon!=null?  63:0,
          child: InkWell(
            onTap: onTapSuffixIcon??(){},
            child: suffixIcon),
        ),
        
        filled: isFilled,
        fillColor:filledColor??  AppUi.colors.hintColor,
        
        suffixIconConstraints: const BoxConstraints(minWidth: 63),
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 10, vertical: Constants.getwidth(context) * 0.0153),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius?? 5),
            borderSide: BorderSide(
                color: borderColor ?? AppUi.colors.hintColor, )),
        disabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(radius??5),

            borderSide: BorderSide(
                color: borderColor ?? AppUi.colors.hintColor,)),
        enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(radius?? 5),

            borderSide: BorderSide(
                color: borderColor ?? AppUi.colors.hintColor, )),
        focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radius??5),

            borderSide: BorderSide(
                color: borderColor ?? AppUi.colors.mainColor, )),
      ),
    );
  }
}
