import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/view/components/dialog/exit_dialog.dart';
import 'package:play_lab/view/screens/account/profile/body/profile_complete_body.dart';
import 'package:play_lab/view/will_pop_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../data/controller/account/profile_controller.dart';
import '../../../../data/repo/account/profile_repo.dart';
import '../../../../data/services/api_service.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({super.key});

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(
      apiClient: Get.find(),
    ));
    Get.put(ProfileController(profileRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProfileController>().loadProfileInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: Scaffold(
        backgroundColor: MyColor.colorBlack,
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              showExitDialog(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: MyColor.colorWhite,
            ),
          ),
          backgroundColor: Colors.transparent,
          title: const Text(MyStrings.profileComplete),
          centerTitle: true,
        ),
        body: const ProfileCompleteBody(),
      ),
    );
  }
}
