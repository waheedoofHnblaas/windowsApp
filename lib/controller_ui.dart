import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_windows_app/constants.dart';
import 'package:window_manager/window_manager.dart';

class UiController extends GetxController {
  bool textFieldIsShow = false;
  bool showChat = false;

  final focusNode = FocusNode();
  TextEditingController textMessageController = TextEditingController();

  List<String> listChats = [];

  @override
  void onInit() {
    super.onInit();
  }

  changeTextFieldIsShow() async {
    textFieldIsShow = !textFieldIsShow;
    if (textFieldIsShow) {
      await windowManager.setSize(Size(AppDims.width, AppDims.height));
    } else {
      showChat = false;

      await windowManager.setSize(Size(AppDims.smallWidth, AppDims.height));
    }
    // windowManager.setAlignment(Alignment.bottomRight, animate: true);
    print(await windowManager.getPosition());
    // await windowManager.setPosition(await windowManager.getPosition());
    if (!textFieldIsShow) {
      await windowManager.getPosition().then((value) async {
        print(value.dx);

        await windowManager
            .setPosition(Offset(value.dx + AppDims.textFieldWidth, value.dy));
        return value.dx;
      });
    } else {
      await windowManager.getPosition().then((value) async {
        print(value.dx);

        await windowManager
            .setPosition(Offset(value.dx - AppDims.textFieldWidth, value.dy));
        return value.dx;
      });
    }
    if (showChat&&textFieldIsShow) {
      print('textFieldIsShow-=====showChat==========');
      await windowManager.getPosition().then(
        (value) async {
          await windowManager.setPosition(
            Offset(value.dx - AppDims.textFieldWidth,
                value.dy + AppDims.chatHeight),
          );
          return "${value.dx}=========";
        },
      );
    }else{
      print('object-===============');
    }

    update();
  }

  Future<void> send(context) async {
    await windowManager.setSize(Size(AppDims.width, AppDims.chatHeight));
    if (!showChat) {
      print('objec1t1');
      // windowManager.center();
      await windowManager.getPosition().then(
            (value) async {
          await windowManager.setPosition(
            Offset(value.dx,
                value.dy - AppDims.chatHeight+AppDims.smallHeight),
          );
          return "${value.dx}=========";
        },
      );
    }else{
      print('objec2t2');
      await windowManager.getPosition().then(
            (value) async {
          await windowManager.setPosition(
            Offset(value.dx,
                value.dy + AppDims.height-AppDims.smallHeight),
          );
          return "${value.dx}=========";
        },
      );
    }
    showChat = true;
    // windowManager.setAlignment(Alignment.bottomRight, animate: true);
    listChats.add(textMessageController.text);
    textMessageController.clear();
    FocusScope.of(context).requestFocus(focusNode);

    update();
    // await scrollController.animateTo(
    //   scrollController.position.maxScrollExtent.isNaN
    //       ? 0
    //       : scrollController.position.minScrollExtent,
    //   duration: const Duration(milliseconds: 600),
    //   curve: Curves.easeOut,
    // );
    print(listChats);
  }

  bool isShowExit = false;

  void showExit() {
    isShowExit = true;
    update();
  }

  void notShowExit() {
    isShowExit = false;
    update();
  }

  bool secondChat = false;

  void showSecondChat() {
    secondChat = !secondChat;
    update();
  }
}
