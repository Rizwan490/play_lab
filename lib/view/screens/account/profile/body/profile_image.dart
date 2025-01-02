import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:play_lab/core/utils/my_images.dart';
import 'package:play_lab/data/controller/account/profile_controller.dart';
import 'package:play_lab/view/components/image/circle_image_button.dart';
import 'package:play_lab/view/components/image/my_image_widget.dart';
import '../../../../../core/utils/my_color.dart';

class ProfileWidget extends StatefulWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;
  double height;
  double width;

  ProfileWidget({
    super.key,
    required this.imagePath,
    required this.onClicked,
    this.isEdit = false,
    this.height = 128,
    this.width = 128,
  });

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (!widget.isEdit || widget.imagePath.isEmpty) ...[
            buildDefaultImage()
          ] else ...[
            buildImage(),
          ],
          widget.isEdit
              ? Positioned(
                  bottom: 0,
                  right: -4,
                  child: GestureDetector(
                      onTap: () {
                        _openGallery(context);
                      },
                      child: buildEditIconMethod(MyColor.primaryColor)),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget buildImage() {
    final Object image;

    if (imageFile != null) {
      image = FileImage(File(imageFile!.path));
    } else if (widget.imagePath.contains('http')) {
      image = NetworkImage(widget.imagePath);
    } else {
      image = const AssetImage(MyImages.profile);
    }
    return ClipOval(
      child: Material(
        color: MyColor.colorWhite,
        child: imageFile != null
            ? Ink.image(
                image: image as ImageProvider,
                fit: BoxFit.cover,
                width: 90,
                height: 90,
                child: GestureDetector(
                  onTap: widget.onClicked,
                ),
              )
            : MyImageWidget(
                imageUrl: widget.imagePath,
                isProfile: true,
                width: 90,
                height: 90,
              ),
      ),
    );
  }

  Widget buildDefaultImage() {
    return ClipOval(
      child: Material(
        color: MyColor.transparentColor,
        child: const CircleImageWidget(
          imagePath: MyImages.profile,
          width: 90,
          height: 90,
          isAsset: true,
        ),
      ),
    );
  }

  Widget buildEditIconMethod(Color color) => buildCircle(
        child: buildCircle(
            child: Icon(
              widget.isEdit ? Icons.add_a_photo : Icons.edit,
              color: Colors.white,
              size: 20,
            ),
            all: 8,
            color: color),
        all: 3,
        color: Colors.white,
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);

    setState(() {
      Get.find<ProfileController>().imageFile = File(result!.files.single.path!);
      imageFile = XFile(result.files.single.path!);
    });
  }
}
