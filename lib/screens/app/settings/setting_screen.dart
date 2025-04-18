import 'package:database_app/api/controllers/users_api_controller.dart';
import 'package:database_app/models/process_response.dart';
import 'package:database_app/utils/context_extension.dart';
import 'package:database_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../getx/user_getx_controller.dart';
import '../../../prefs/shared_pref_controller.dart';
import '../../../getx/language_getx_controller.dart';


class SettingScreen extends StatefulWidget {
   SettingScreen({Key? key}) : super(key: key);
  UserGetxController controller =Get.put<UserGetxController>(UserGetxController());


  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late String _language;
  // late String _name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _name=SharedPrefController().getValueFor<String>(PrefKeys.name.name)!;
    _language =
        SharedPrefController().getValueFor<String>(PrefKeys.language.name) ??
            'en';
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<UserGetxController>(builder: (UserGetxController controller) {
      return Scaffold(
        backgroundColor: Color(0xffF4F5F7),
        appBar: AppBar(
          title: AppText(
            text: context.localizations.settings,
            fontSize: 17.sp,
            color: Color(0xFF222B45),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w, /*, vertical: 10.h*/
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                height: 70.h,
                width: 327.w,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      // backgroundColor: Color(0xffFF7750),
                      backgroundImage: AssetImage('images/avatar.png'),

                      radius: 35,
                    ),
                    SizedBox(width: 20.w,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                            text: controller.name.value,

                            /*SharedPrefController()
                              .getValueFor<String>(PrefKeys.name.name)!,*/
                            fontSize: 18.sp,
                            color: Colors.black),
                        AppText(
                            text: SharedPrefController()
                                .getValueFor<String>(PrefKeys.mobile.name)!,
                            fontSize: 12.sp,
                            color: Color(0xff36596A)),
                      ],
                    ),
                    // CircleAvatar(
                    //   radius: 20,
                    //   backgroundColor: Color(0xffF4F5F7),
                    //   child: Center(
                    //     child: InkWell(
                    //       onTap: (){Navigator.pushNamed(context, '/edit_profile_screen');},
                    //       child: Icon(Icons.mode_edit_outline_outlined,
                    //           color: Color(0xff36596A)),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 10.h,
              // ),
              Container(
                width: 327.w,
                height: 550.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                          text:  context.localizations.profile_setting,
                          fontSize: 18.sp,
                          color: Color(0xff36596A)),
                      // SizedBox(height: 10.h,),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/edit_profile_screen');
                        },
                        child: _buildProfileSeting(
                            icon: Icon(Icons.person),
                            title: context.localizations.profile,
                            subTitle: controller.name.value,
                            actionIcon: IconButton(icon: Icon(Icons.mode_edit_outline_outlined),
                              color: Color(0xffFF7750) ,onPressed: (){
                                Navigator.pushNamed(context, '/edit_profile_screen');
                              },)),
                      ),
                      // SizedBox(height: 10.h,),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/change_mobile_screen');
                        },
                        child: _buildProfileSeting(
                            icon: Icon(Icons.phone),
                            title: context.localizations.edit_mobile,
                            subTitle: 'Last update (19/8/2020)',
                            actionIcon: IconButton(icon: Icon(Icons.mode_edit_outline_outlined),
                              color: Color(0xffFF7750) ,onPressed: (){
                                Navigator.pushNamed(context, '/change_mobile_screen');

                              },)
                        ),
                      ),

                      // SizedBox(height: 10.h,),
                      InkWell(
                        onTap: (){
                          _showLangaugeBottomSheet();
                        },
                        child: _buildProfileSeting(
                            icon: Icon(Icons.language),
                            title: context.localizations.language,
                            subTitle: SharedPrefController().getValueFor<String>(PrefKeys.language.name)=='ar'?'Arabic' :'English'
                            ,
                            actionIcon: IconButton(icon: Icon(Icons.mode_edit_outline_outlined),
                              color: Color(0xffFF7750) ,onPressed: (){
                                _showLangaugeBottomSheet();
                              },)),
                      ),

                      // SizedBox(height: 10.h,),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/change_password_screen');
                        },
                        child: _buildProfileSeting(
                            icon: Icon(Icons.lock),
                            title: context.localizations.change_pass,
                            subTitle: 'Last update (19/8/2020)',
                            actionIcon: IconButton(icon: Icon(Icons.mode_edit_outline_outlined),
                              color: Color(0xffFF7750) ,onPressed: (){
                                Navigator.pushNamed(context, '/change_password_screen');
                              },)),
                      ),
                      // SizedBox(height: 16.h,),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/contact_us_screen');
                        },
                        child: Container(
                          height: 60.h,
                          width: 295.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffF4F5F7)),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 19.w, vertical: 15.h),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.message),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(
                                        text: context.localizations.contact_us,
                                        fontSize: 14.sp,
                                        color: Color(0xff36596A)),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                  // padding: EdgeInsetsDirectional.zero,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/contact_us_screen');
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xffFF7750),
                                    )),

                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/about_us_screen');
                        },
                        child: Container(
                          height: 60.h,
                          width: 295.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffF4F5F7)),
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 19.w, vertical: 15.h),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.info),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(
                                        text: context.localizations.about_us,
                                        fontSize: 14.sp,
                                        color: Color(0xff36596A)),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xffFF7750),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white,
                ),
              ),

              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                height: 40.h,
                width: 327.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(

                      child: AppText(

                          text: context.localizations.logout,
                          fontSize: 14.sp,
                          color: Color(0xff36596A)),
                      onTap: () async{
                        ProcessResponse processResponse =await UsersApiController().logout();
                        if(processResponse.success){
                          Navigator.pushReplacementNamed(context, '/login_screen');
                          context.showSnackBar(message: processResponse.message ,error: !processResponse.success );
                        }


                      },
                    ),
                    // Icon(Icons.logout),
                  ],
                ),

              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      );

    },);
  }

  void _showLangaugeBottomSheet() async {
    String? langCode = await showModalBottomSheet<String>(
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        context: context,
        builder: (context) {
          return (BottomSheet(
            backgroundColor: Colors.transparent,
            onClosing: () {},
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.language_title,
                          style: GoogleFonts.nunito(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          AppLocalizations.of(context)!.language_sub_title,
                          style: GoogleFonts.nunito(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.black45,
                              height: 1.0),
                        ),
                        const Divider(),
                        RadioListTile<String>(
                            title: Text(
                              'English',
                              style: GoogleFonts.nunito(),
                            ),
                            value: 'en',
                            groupValue: _language,
                            onChanged: (String? value) {
                              if (value != null) {
                                setState(() => _language = value);
                                Navigator.pop(context, 'en');
                              }
                            }),
                        RadioListTile<String>(
                            title: Text(
                              'العربية',
                              style: GoogleFonts.nunito(),
                            ),
                            value: 'ar',
                            groupValue: _language,
                            onChanged: (String? value) {
                              if (value != null) {
                                setState(() => _language = value);
                                Navigator.pop(context, 'ar');
                              }
                            }),

                        // RadioListTile<String>
                      ],
                    ),
                  );
                },
              );
            },
          ));
        });
    if (langCode != null) {
      Future.delayed(Duration(milliseconds: 500), () {
        LanguageGetxController.to.changeLanguage();
      });
    }
  }

  Container _buildProfileSeting(
      {required Widget icon, required String title, String subTitle = '' ,required IconButton actionIcon}) {
    return Container(
      height: 73.h,
      width: 295.w,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffF4F5F7)),
          borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 15.h),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              width: 15.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(text: title, fontSize: 14.sp, color: Color(0xff36596A)),
                AppText(
                  text: subTitle,
                  fontSize: 12.sp,
                  color: Color(0xff9A9A9A),
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xffF4F5F7),
              child: Center(
                child: actionIcon /*Icon(Icons.mode_edit_outline_outlined,
                    color: Color(0xff36596A))*/,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
