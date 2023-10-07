import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_windows_app/constants.dart';
import 'package:new_windows_app/controller_ui.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/gestures.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UiController uiController = Get.put(UiController());
    www(int index) {
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xff002a2f),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: AppDims.width / 3,
        child: Column(
          children: [
            Title(
              color: Colors.white,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.minimize,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.window,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Text(
              index.toString(),
              style: const TextStyle(color: Colors.red),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                scrollDirection: Axis.vertical,
                // controller:
                //     uiController.scrollController.isNull
                //         ? ScrollController()
                //         : uiController.scrollController,
                itemCount: uiController.listChats.length,
                itemBuilder: (context, index) => Text(
                  uiController
                      .listChats[uiController.listChats.length - index - 1],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }


    windowManager.setPreventClose(true);
    return Scaffold(
      body: GetBuilder<UiController>(
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        height: uiController.showChat ? AppDims.chatHeight : 0,
                        child: uiController.showChat
                            ? uiController.listChats.isNotEmpty
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          controller:
                                              uiController.listController,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              www(index),
                                          itemCount: 10,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // uiController.scroll();
                                          uiController.showSecondChat();
                                        },
                                        icon: Icon(
                                          uiController.secondChat
                                              ? Icons.arrow_back_ios_rounded
                                              : Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text('empty')
                            : Container(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (!uiController.secondChat) {
                          await windowManager.minimize();
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                        width:
                            uiController.secondChat ? 200 : AppDims.smallWidth,
                        decoration: BoxDecoration(
                          color: uiController.secondChat
                              ? const Color(0xff002a2f)
                              : Colors.transparent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.ltr,
                children: [
                  Expanded(
                    flex: uiController.textFieldIsShow ? 6 : 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff002a2f),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      width: uiController.textFieldIsShow
                          ? AppDims.textFieldWidth
                          : 0,
                      child: uiController.textFieldIsShow
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      focusNode: uiController.focusNode,
                                      controller:
                                          uiController.textMessageController,
                                      onFieldSubmitted: (value) {
                                        print(value);
                                        uiController.send(context);
                                      },
                                      cursorColor: Colors.white,
                                      autofocus: true,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          // await windowManager.setSkipTaskbar(true);
                                          // await windowManager.setPreventClose(true);
                                          // final tray = SystemTray();
                                          // await tray.initSystemTray(
                                          //   iconPath: 'assets/robot.png',
                                          // );
                                        },
                                        icon: const Icon(
                                          Icons.copy,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          uiController.send(context);
                                        },
                                        icon: const Icon(
                                          Icons.send,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                  ),
                  Expanded(
                    child: Transform.scale(
                      scale: 1,
                      alignment: Alignment.centerRight,
                      transformHitTests: false,
                      child: DragToMoveArea(
                        child: GestureDetector(
                          onTap: () async {
                            // final renderBox =
                            //     context.findRenderObject() as RenderBox;
                            // final local = renderBox.size
                            //     .center(await windowManager.getPosition());
                            // final global = renderBox.localToGlobal(local);
                            // print(global);

                            uiController.changeTextFieldIsShow();
                          },
                          child: SizedBox(
                            width: AppDims.smallWidth,
                            height: AppDims.smallHeight,
                            child: MouseRegion(
                              onEnter: (event) {
                                uiController.showExit();
                              },
                              onExit: (event) {
                                uiController.notShowExit();
                              },
                              child: Stack(
                                children: [
                                  Image.asset('assets/robot.png'),
                                  uiController.isShowExit
                                      ? Positioned(
                                    bottom: 0,
                                    left: 30,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: IconButton(
                                        onPressed: () {
                                          windowManager.minimize();
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ),
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
