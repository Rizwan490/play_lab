/*class AddPlayerWidget extends StatefulWidget {
  const AddPlayerWidget({Key? key}) : super(key: key);

  @override
  State<AddPlayerWidget> createState() => _AddPlayerWidgetState();
}

class _AddPlayerWidgetState extends State<AddPlayerWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailsController>(
        builder: (controller) {
          return  Container(
            height: MediaQuery.of(context).size.height*.3,
            color: Colors.black,
            child: Stack(
              children: [
                controller.chewieController !=null && controller.adChewieController?.ChewieController.value.isInitialized == true?
                Center(
                child: AspectRatio(
                aspectRatio: 16/9,
                child: Chewie(
                  controller: controller.adChewieController!,
                ),
              ),
            ): const Center(child: CircularProgressIndicator(color: MyColor.primaryColor)),
              Visibility(
                visible: controller.isAdPlaying && controller.showSkipBtn,
                child: Positioned(
                  right: Get.size.width * 0.02,
                  top: Get.size.height * 0.01,
                  child: GestureDetector(
                    onTap: () {
                      controller.onAdPlayerFinished();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Text(
                            MyString.skip.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )],
          ));
        }
    );
  }
}*/
