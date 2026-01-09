import 'dart:async';
import 'dart:io';
import 'package:almaren_desktop/models/chat.dart';
import 'package:almaren_desktop/models/message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 聊天页面
class ChatLogic extends GetxController {
  /// 当前会话
  Chat chat;

  ChatLogic(this.chat);

  /// 消息列表
  final List<Message> messages = List.empty(growable: true);

  /// 滚动条控制器
  final ScrollController scrollController = ScrollController();

  final FocusNode focusNode = FocusNode();

  final TextEditingController textEditingController = TextEditingController();

  /// 是否拥有滚动条
  bool hasScroll = false;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  @override
  void onClose() {
    focusNode.dispose();
    textEditingController.dispose();
    super.onClose();
  }

  void _initData() {
    messages.add(
      TextMessage(
        avatar: "assets/images/avatar/2.jpg",
        name: "滨崎步",
        self: true,
        text: 'Hello, I\'m very pleased to meet you',
      ),
    );

    messages.add(
      TextMessage(
        avatar: chat.portrait,
        name: "滨崎步",
        self: false,
        text: 'Hello, I\'m Ayumi Hamasaki.',
      ),
    );

    messages.add(
      TextMessage(
        avatar: chat.portrait,
        name: "滨崎步",
        self: false,
        text: '??? 😁 Hello',
      ),
    );

    messages.add(
      ImageMessage(
        avatar: chat.portrait,
        name: "滨崎步",
        self: false,
        image: "assets/images/intro_bg.jpg",
        w: 1342,
        h: 2013,
      ),
    );
  }

  /// 检查滚动行为
  void checkScrollPhysics({bool force = false}) async {
    // 不能滚动才检查
    if (force || !hasScroll) {
      if (scrollController.hasClients) {
        await Future.delayed(const Duration(milliseconds: 150));
        // 计算内部高度
        //double max = scrollController.position.maxScrollExtent;
        if (scrollController.position.extentInside <
            scrollController.position.extentTotal) {
          if (!hasScroll) {
            hasScroll = true;
            update(); // 刷新UI
            debugPrint("CheckScrollPhysics : 现在可以滚动。");
          }
        } else {
          if (hasScroll) {
            hasScroll = false;
            update(); // 刷新UI
            debugPrint("CheckScrollPhysics : 不允许滚动。");
          }
        }
      }
    }
  }

  FutureOr<dynamic> loadMore() {}

  /// 插入消息并发送，然后刷新UI
  void _insertMessageSend(Message msg) {
    // 发送
    //service.sendMsg(msg);
    // 告知给会话列表
    //service.sendMsgToChats(ChatsEvent(chatsData.targetId, msg));
    // 处理消息
    messages.insert(0, msg);
    update(); // 刷新UI
    checkScrollPhysics();
  }

  void onTapSend() async {
    String text = textEditingController.text;

    final TextMessage msg = TextMessage(
      text: text,
      avatar: "assets/images/avatar/2.jpg",
      name: "",
      self: true,
    );
    _insertMessageSend(msg);
    await Future.delayed(const Duration(milliseconds: 50));
    textEditingController.clear();
  }

  /// 相册
  void onTapAlbum() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      final msg = ImageMessage(
        avatar: chat.portrait,
        name: "",
        self: true,
        image: file.path,
        w: 100,
        h: 100,
      );
      _insertMessageSend(msg);
    } else {
      // User canceled the picker
    }

    // final List<AssetEntity>? assets = await PickAssetsUtils.pickAssets(
    //   type: RequestType.common,
    //   // specialPickerType: SpecialPickerType.wechatMoment,
    // );
    // if (assets != null) {
    //   for (final asset in assets) {
    //     if (asset.type == AssetType.image) {
    //       await _sendImage(asset);
    //     } else if (asset.type == AssetType.video) {
    //       // await _sendVideo(asset);
    //     }
    //   }
    // }
  }

  /// 处理图片和上传
  // Future _sendImage(AssetEntity asset) async {
  //   final File? file = await asset.file;
  //   if (file?.existsSync() == true) {
  //     final msg = ImageMessage(
  //       avatar: chat.portrait,
  //       name: "",
  //       self: true,
  //       image: file!.path,
  //       w: asset.orientatedWidth.toDouble(),
  //       h: asset.orientatedHeight.toDouble(),
  //     );
  //     _insertMessageSend(msg);
  //   }
  // }

  /// 点击拍摄
  void onTapCamera() async {
    // final AssetEntity? asset = await PickAssetsUtils.pickAssetsFromCamera();
    // if (asset != null) {
    //   if (asset.type == AssetType.image) {
    //     await _sendImage(asset);
    //   } else if (asset.type == AssetType.video) {
    //     // await _sendVideo(asset);
    //   }
    // }
  }

  void onTapMenuFile() {}

  void onTapMenuTransfer() {}

  void onTapMenuRedPacket() {}

  void onTapMenuCollect() {}
}
