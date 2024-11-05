import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants.dart';
import '../../../Utils/Routes.dart';

class AccountLoginScreen2 extends StatefulWidget {
  const AccountLoginScreen2({Key? key}) : super(key: key);

  @override
  State<AccountLoginScreen2> createState() => _AccountLoginScreen2State();
}

class _AccountLoginScreen2State extends State<AccountLoginScreen2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          
          child: Padding(
            padding: mainBodyPadding,
            child: Column(
              children: [
                Center(
                  child: Text.rich(
                    TextSpan(
                        text: 'SOUL',
                        style: Theme.of(context).textTheme.displayLarge,
                        children:[
                          TextSpan(
                            text: ' MILUN',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ]
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.08,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/sample_profile_pic_male.png",
                      scale: 7,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.04),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            "Delete from this device",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.519),
                  child: GestureDetector(
                    onTap: toLogInScreen,
                    child: Text(
                      "Login with another account?",
                      style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void toLogInScreen() async {
    Get.toNamed(RoutesClass.logInPage);
  }
}
