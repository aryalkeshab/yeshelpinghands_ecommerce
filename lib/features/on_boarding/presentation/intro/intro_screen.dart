import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const dummyIntroBody =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Choose Your Needs",
          body: dummyIntroBody,
          image:
              "https://i.pinimg.com/originals/f8/19/0f/f8190f263b8257fb1939f62a648e2403.jpg",
        ),
        PageViewModel(
            image:
                "https://adwisely.com/wp-content/uploads/2010/05/10-great-YouTube-Channels-for-eCommerce.png",
            title: "Digital or Easy Payment",
            body: dummyIntroBody),
        PageViewModel(
            image:
                "https://static.vecteezy.com/system/resources/previews/014/550/733/original/trucks-deliver-goods-to-the-recipient-online-ordering-concept-png.png",
            // "https://startupnation.com/wp-content/uploads/2018/02/Screen-Shot-2018-02-05-at-10.29.47-AM.png",
            title: "Quick Delivery",
            body: dummyIntroBody),
      ],
      onDone: () {
        Get.toNamed(Routes.chooseLanguage);
      },
      next: Text('Next',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Colors.white)),
      done: Text('Start',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Colors.white)),
      showSkipButton: true,
      onSkip: () {
        Get.toNamed(Routes.chooseLanguage);
      },
    );
  }
}

class IntroductionScreen extends HookWidget {
  final Color? skipColor;
  final bool? showSkipButton;
  final Widget? skip;
  final Widget next;
  final Widget done;
  final VoidCallback onDone;
  final VoidCallback? onSkip;
  final List<PageViewModel> pages;

  const IntroductionScreen({
    Key? key,
    this.skipColor,
    this.showSkipButton = false,
    this.skip,
    required this.next,
    required this.done,
    required this.onDone,
    this.onSkip,
    required this.pages,
  }) : super(key: key);

  bool isLastPage(int lengthOfPage, int currentPage) {
    return currentPage == lengthOfPage - 1;
  }

  @override
  Widget build(BuildContext context) {
    final pageController = useMemoized(() => PageController());
    final pageIndex = useState(0);
    return Scaffold(
      body: SafeArea(
        child: BaseWidget(builder: (context, config, theme) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: config.appEdgePadding()),
            child: Stack(
              children: [
                Positioned(
                  height: MediaQuery.of(context).size.height,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: pageController,
                        onPageChanged: (pageNo) => pageIndex.value = pageNo,
                        // itemCount: pController.boardingPages.length,
                        itemCount: pages.length,
                        itemBuilder: (context, index) {
                          final page = pages[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              page.image != null
                                  ? CachedNetworkImage(
                                      imageUrl: page.image!,
                                      fit: BoxFit.fitWidth,
                                      width: double.maxFinite,
                                      height: 300,
                                    )
                                  : const SizedBox.shrink(),
                              config.verticalSpaceMedium(),
                              Text(
                                "${page.title}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              config.verticalSpaceMedium(),
                              Text(
                                "${page.body}",
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 40,
                  child: Row(
                    children: List.generate(
                      pages.length,
                      (index) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: pageIndex.value == index
                                ? Colors.red
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 35,
                  child: FloatingActionButton.extended(
                    elevation: 3.0,
                    onPressed: isLastPage(pages.length, pageIndex.value)
                        ? () => onDone()
                        : () {
                            pageController.nextPage(
                                duration: 300.milliseconds, curve: Curves.ease);
                          },
                    label: pages.length - 1 == pageIndex.value
                        ? InkWell(
                            child: done,
                          )
                        : next,
                  ),
                ),
                if (showSkipButton!)
                  Positioned(
                    right: 0,
                    top: 20,
                    child: InkWell(
                      onTap: onSkip,
                      child: Text(
                        'Skip',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color:
                                  skipColor ?? Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class PageViewModel {
  /// Title of page
  final String? title;

  /// Title of page
  final Widget? titleWidget;

  /// Text of page (description)
  final String? body;

  /// Widget content of page (description)
  final Widget? bodyWidget;

  /// Image of page
  /// Tips: Wrap your image with an alignment widget like Align or Center
  final String? image;

  /// Footer widget, you can add a button for example
  final Widget? footer;

  /// If widget Order is reverse - body before image
  final bool reverse;

  /// Wrap content in scrollView
  final bool useScrollView;

  PageViewModel({
    this.title,
    this.titleWidget,
    this.body,
    this.bodyWidget,
    this.image,
    this.footer,
    this.reverse = false,
    this.useScrollView = true,
  });
}
