import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImagePickWidget extends HookConsumerWidget {
  const ImagePickWidget({
    super.key,
    required this.imageFile,
    required this.image,
    required this.defaultWidget,
    this.editIcon = false,
    required this.builder,
  });

  final ValueNotifier<File?> imageFile;
  final String image;
  final Widget defaultWidget;
  final bool editIcon;
  final Widget Function(ImageProvider<Object>?, Widget?) builder;

  @override
  Widget build(BuildContext context, ref) {
    void chooseImage(type) async {
      XFile? image;
      if (type == "camera") {
        image = await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 10);
      } else {
        image = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 25);
      }
      if (image != null) {
        imageFile.value = File(image.path);
        // final bytes = imageFile.value!.readAsBytesSync();
        // avatar.value =
        //     Uri.dataFromBytes(bytes, mimeType: "appication/png").toString();
        Logger.v(imageFile.value!.path);
      }
    }

    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          KInkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: context.theme.scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: radius0,
                ),
                builder: (context) => ImagePickOptionWidget(
                  onCameraTap: () {
                    chooseImage("camera");

                    Navigator.pop(context);
                  },
                  onGalleryTap: () {
                    chooseImage("gallery");

                    Navigator.pop(context);
                    Logger.v("gallery");
                  },
                ),
              );
            },
            child: builder(
              imageFile.value != null
                  ? Image.file(imageFile.value!).image
                  : image.isNotEmpty
                      ? CachedNetworkImageProvider(image)
                      : null,
              imageFile.value == null && image.isEmpty ? defaultWidget : null,
            ),
          ),
          Visibility(
            visible: editIcon,
            child: PositionedDirectional(
              bottom: 0,
              end: 0,
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.white,
                child: CircleAvatar(
                  radius: 16.r,
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePickOptionWidget extends StatelessWidget {
  const ImagePickOptionWidget({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: crossCenter,
        children: [
          gap24,
          Text(
            "context.local.chooseImageSource",
            style: context.titleSmall.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          gap10,
          Row(
            mainAxisAlignment: mainCenter,
            children: [
              KInkWell(
                borderRadius: radius10,
                onTap: () => onCameraTap(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                  child: Column(
                    children: [
                      Icon(
                        Icons.camera,
                        color: context.color.secondary,
                        size: 60.sp,
                      ),
                      Text(
                        "context.local.fromCamera",
                        style: context.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              gap20,
              KInkWell(
                borderRadius: radius10,
                onTap: () => onGalleryTap(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                  child: Column(
                    children: [
                      Icon(
                        Icons.image,
                        color: context.color.secondary,
                        size: 60.sp,
                      ),
                      Text(
                        "context.local.fromGallery",
                        style: context.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          gap20,
        ],
      ),
    );
  }
}
