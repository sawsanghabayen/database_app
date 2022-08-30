import 'package:database_app/database/controllers/user_db_controller.dart';
import 'package:database_app/models/process_response.dart';
import 'package:database_app/prefs/shared_pref_controller.dart';
import 'package:database_app/screens/widgets/app_text_field.dart';
import 'package:database_app/utils/context_extension.dart';
import 'package:database_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../provider/language_provider.dart';
import '../../widgets/app_text.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with Helpers {
  late TextEditingController _currentTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _repeatPasswordTextController;
  bool _obsecure = true;
  bool _obsecurePass2 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _repeatPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _currentTextController.dispose();
    _passwordTextController.dispose();
    _repeatPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          title: AppText(
            text: 'Change Password',
            fontSize: 17.sp,
            color: Color(0xFF222B45),
          ),


      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Change Password',
              style: GoogleFonts.nunito(
                  fontSize: 22.sp,
                  color: Color(0xFF3E3E3E),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.h,
            ),

            AppTextField(
                hint: 'Current Password',
                obscureText: _obsecure,
                prefixIcon: Icons.lock,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => _obsecure = !_obsecure);
                    },

                    icon: Icon(
                        _obsecure ? Icons.visibility : Icons.visibility_off)),
                keyboardType: TextInputType.text,
                controller: _passwordTextController),

            SizedBox(
              height: 20.h,
            ),
            AppTextField(
                hint: 'Enter new password',
                obscureText: _obsecurePass2,
                prefixIcon: Icons.lock,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => _obsecurePass2 = !_obsecurePass2);
                    },
                    // Icons.visibility
                    icon: Icon(_obsecurePass2 ? Icons.visibility : Icons
                        .visibility_off)
                ),
                keyboardType: TextInputType.text,
                controller: _passwordTextController),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
                hint: 'Repeat password',
                obscureText: _obsecurePass2,
                prefixIcon: Icons.lock,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => _obsecurePass2 = !_obsecurePass2);
                    },
                    // Icons.visibility
                    icon: Icon(_obsecurePass2 ? Icons.visibility : Icons
                        .visibility_off)
                ),
                keyboardType: TextInputType.text,
                controller: _passwordTextController),

            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  // print(_emailTextController.text);
                  // print(_passwordTextController.text);
                  Navigator.pushReplacementNamed(context, '/');
                  // _performLogin();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(325.w, 63.83.h),
                    primary: Color(0xffFF7750),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r))),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.nunito(fontSize: 16.sp ,color: Color(0xffFFFFFF) ,fontWeight: FontWeight.bold),
                )),

            SizedBox(height: 50.h,),
          ],
        ),
      ),
    );
  }


}