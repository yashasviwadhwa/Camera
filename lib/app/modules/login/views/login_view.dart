import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 227, 227, 227).withOpacity(0.5),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Color(0XffFF007F),
        ),
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: "Link",
            style: TextStyle(
              color: const Color(0XffFF007F),
              fontSize: 20.sp,
            ),
            children: [
              const TextSpan(
                text: " with ",
                style: TextStyle(
                  color: Color(0XffFF007F),
                ),
              ),
              TextSpan(
                text: "Phone",
                style: TextStyle(
                  color: const Color(0Xff460C68).withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: ListView(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Added Numbers",
              style: TextStyle(color: Colors.black, fontSize: 20.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 17.r,
                  child: Image.asset("name"),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        "+91 9354063013",
                        style:
                            TextStyle(fontSize: 15.sp, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    minimumSize: Size(20.w, 30.h),
                  ),
                  child: const Text(
                    'Remove',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              children: [
                const Icon(Icons.mobile_off),
                SizedBox(
                  width: 8.h,
                ),
                Text(
                  "Add a number",
                  style: TextStyle(fontSize: 20.sp),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: controller.countryController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "+91",
                            ),
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(fontSize: 23.sp, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Expanded(
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
