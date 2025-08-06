import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/product/id/controller.dart';
import 'package:ESGVida/screens/shopping/product/id/pages/page_enum.dart';
import 'package:ESGVida/screens/shopping/product/id/pages/comment_list/widgets/comment_widget.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class CommentListPage extends StatelessWidget {
  const CommentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    return GetX<ProductCommentListController>(
      init: ProductCommentListController(detailId: productController.detailId),
      initState: (state) {
        state.controller!.fetchMorePageData();
      },
      builder: (controller) {
        final size = MediaQuery.of(context).size;
        /**
         * 1. 注意在一个widget子树下面最好不要有多个PopScope就好了
         * 2. 错误：
         * - [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: 'package:flutter/src/widgets/navigator.dart': Failed assertion: line 5277 pos 12: '!_debugLocked': is not true.
         * - PopScope 的 onPopInvoked 被调用时，实际导航动作已经发生。这意味着在 onPopInvoked 回调中再次调用 Navigator.pop，可能会与导航栈的状态产生冲突。
         * - 方法：延迟 Navigator.pop 的执行，但是会返回上上级
         * - 最终解决方法：
         *   - 实际上是未理解参数 didPop 和 PopScope
         * - PopScope：拦截此界面发生的pop事件，其他界面不管，主要是做如一个界面多个页面等功能
         *   - onPopInvoked:
         *     - didPop: 当当前界面发生pop事件，则为true
         *     - 如果确认pop，在这个方法执行back即可
         */
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (didPop) {
              return;
            }
            productController.currentPage.value = ProductPageEnum.MAIN;
          },
          child: Container(
            color: CommonColor.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            // 这里不会为空，为空打不开这里
            child: controller.isPageDataFirstLoading.isTrue
                ? SizedBox(
                    height: size.height * 0.75,
                    child: loadingWidget(),
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      _onScrollEnd(notification, controller); // 监听滚动事件
                      return true;
                    },
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.pageData.length,
                          itemBuilder: (context, index) {
                            final data = controller.pageData[index];
                            return CommentWidget(
                              data,
                              onDelete: (comment) async {
                                controller.pageData
                                    .removeWhere((e) => e.id == comment.id);
                              },
                            );
                          },
                        ),
                        if (controller.isMorePageDataLoading.isTrue)
                          loadingWidget(),
                        if (!controller.hasNext)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(LanguageGlobalVar.NO_MORE.tr),
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _onScrollEnd(ScrollNotification notification,
      ProductCommentListController controller) {
    final metrics = notification.metrics;
    if (metrics.pixels == metrics.maxScrollExtent &&
        controller.hasNext &&
        controller.isMorePageDataLoading.isFalse) {
      controller.fetchMorePageData();
    }
  }
}
 // todo 新增评论，应该放在订单中进行评论，而不是这里
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     controller.pageData.isNotEmpty
              //         ? const Text(
              //             "Reviews",
              //             style: CommonStyle.black18Bold,
              //           )
              //         : const SizedBox(),
              //     commonElevatedButton(
              //       backgroundColor: CommonColor.primaryColor,
              //       height: 32,
              //       width: size.width * 0.3,
              //       onTapButton: () {
              //         Get.to(
              //           () => AddCommentCcreen(
              //             productId: controller.detail!.id!,
              //           ),
              //         );
              //       },
              //       child: const Text(
              //         "Add Review",
              //         style: CommonStyle.white14Medium,
              //       ),
              //       borderRadius: 5,
              //       elevation: 1,
              //     ),
              //   ],
              // ),
              // if (controller.pageData.isNotEmpty)
              //   const Text(
              //     "Rating's & Review's",
              //     style: CommonStyle.black14Medium,
              //   ),