import 'package:almaren_desktop/models/chat.dart';
import 'package:almaren_desktop/models/message.dart';
import 'package:almaren_desktop/page/chat/chat_input_controller.dart';
import 'package:almaren_desktop/page/chat/chat_logic.dart';
import 'package:almaren_desktop/page/chat/chat_message_item.dart';
import 'package:almaren_desktop/theme/colors.dart';
import 'package:almaren_desktop/theme/dimensions.dart';
import 'package:almaren_desktop/widgets/avatar_widget.dart';
import 'package:almaren_desktop/widgets/blur_widget.dart';
import 'package:almaren_desktop/widgets/online_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled/size_extension.dart';
import 'package:get/get.dart';

/// 聊天页面
class ChatPage extends StatefulWidget {
  const ChatPage(this.chat, {super.key});

  final Chat chat;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  /// 逻辑控制器
  late ChatLogic logic;

  /// 输入组件控制器
  final ChatInputController _chatInputController = ChatInputController();

  /// 选择模式
  bool isSelectMode = false;

  @override
  void initState() {
    logic = Get.put(ChatLogic(widget.chat));
    logic.chat = widget.chat;
    //Get.put(ChatLogic(), tag: "abc");
    super.initState();
  }

  @override
  void dispose() {
    // 销毁用到的资源
    logic.dispose();
    _chatInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: Dimensions.borderRadiusSmall,
              child: OnlineBoxWidget(
                online: logic.chat.online,
                child: AvatarWidget(
                  size: 40,
                  avatar: logic.chat.portrait,
                ),
              ),
            ),
            16.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  logic.chat.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontFamily: "Poppins",
                  ),
                ),
                2.verticalSpace,
                Text(
                  logic.chat.online ? "Online" : "Offline",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: logic.chat.online
                        ? ThemeColors.greenColor
                        : ThemeColors.greyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        flexibleSpace: BlurWidget(
          child: SizedBox.expand(),
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      //backgroundColor: const Color(0xFFFBFBFB),
      body: _buildBody(),
      bottomNavigationBar: _buildInput(),
    );
  }

  /// Body
  Widget _buildBody() {
    // 未来支持更换背景
    bool hasBackground = false;

    Widget body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (event) {
              // Hide panel when touch ListView.
              _chatInputController.notify();
            },
            onPointerUp: (event) {
              logic.checkScrollPhysics(force: true);
            },
            child: Scrollbar(
              controller: logic.scrollController,
              child: _buildList(),
            ),
          ),
        ),

        Divider(height: 1),

        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/svgs/chat/chatEmoji.webp",
                width: 20,
                height: 20,
              ),
            ),
            IconButton(
              onPressed: logic.onTapAlbum,
              icon: Image.asset(
                "assets/svgs/chat/chatAlbum.webp",
                width: 20,
                height: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/svgs/chat/chatFile.webp",
                width: 20,
                height: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/svgs/chat/chatCall.webp",
                width: 20,
                height: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/svgs/chat/chatCollect.webp",
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),

        KeyboardListener(
          focusNode: logic.focusNode,
          onKeyEvent: (value) {
            if (value is KeyDownEvent &&
                value.logicalKey == LogicalKeyboardKey.enter) {
              // Enter key
              logic.onTapSend();
            }
          },
          child: TextField(
            maxLines: 4,
            controller: logic.textEditingController,
            decoration: InputDecoration(
              filled: false,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 10, right: 20, bottom: 20),
          child: Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: logic.onTapSend,
              child: Text("Send"),
            ),
          ),
        ),
      ],
    );

    /// 设置背景
    // ignore: dead_code
    if (hasBackground) {
      // return Stack(
      //   fit: StackFit.expand,
      //   children: [
      //     CachedNetworkImage(
      //       imageUrl: "https://w.wallhaven.cc/full/yq/wallhaven-yqqg1k.jpg",
      //       fit: BoxFit.cover,
      //       memCacheWidth: 500,
      //     ),
      //     ClipRect(
      //       child: BackdropFilter(
      //         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      //         child: const DecoratedBox(
      //           decoration: BoxDecoration(color: Colors.white70),
      //         ),
      //       ),
      //     ),
      //     body,
      //   ],
      // );
    }
    // ignore: dead_code
    return body;
  }

  /// 输入组件
  Widget _buildInput() {
    return SizedBox();
    // 功能条（输入框、表情按钮、工具按钮等）
    // return BlurWidget(
    //   child: ChatInput(
    //     isSelectMode: isSelectMode,
    //     onTapSend: logic.onTapSend,
    //     onTapAlbum: logic.onTapAlbum,
    //     onTapCamera: logic.onTapCamera,
    //     onTapMenuFile: logic.onTapMenuFile,
    //     onTapMenuTransfer: logic.onTapMenuTransfer,
    //     onTapMenuRedPacket: logic.onTapMenuRedPacket,
    //     onTapMenuCollect: logic.onTapMenuCollect,
    //     chatInputController: _chatInputController,
    //   ),
    // );
  }

  /// 消息列表区域
  Widget _buildList() {
    return GetBuilder<ChatLogic>(
      builder: (controller) {
        return CustomScrollView(
          reverse: true,
          shrinkWrap: true,
          //padding: const EdgeInsets.all(20),
          controller: logic.scrollController,
          physics: !logic.hasScroll
              ? const NeverScrollableScrollPhysics()
              : null,
          slivers: [
            SliverSafeArea(
              sliver: SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList.separated(
                  itemCount: logic.messages.length,
                  itemBuilder: (context, index) {
                    final Message message = logic.messages[index];
                    return ChatMessageItem(
                      index: index,
                      message: message,
                      isSelectMode: isSelectMode,
                      onTapMulti: () {
                        isSelectMode = !isSelectMode;
                        setState(() {});
                      },
                      onTapContent: () {
                        switch (message.kind) {
                          case MessageKind.image:
                            ImageMessage imageMessage = message as ImageMessage;
                            // Get.to(
                            //   () => PreviewImagePage(),
                            //   transition: Transition.noTransition,
                            //   arguments: {
                            //     "hero": message.heroKey,
                            //     "source": imageMessage.image,
                            //   },
                            // );
                            break;
                          // case MsgKind.video:
                          //   VideoMessageUI videoMessage = message as VideoMessageUI;
                          //   Get.toNamed(
                          //     AppRoutes.previewVideo,
                          //     arguments: {
                          //       "source": videoMessage.source,
                          //     },
                          //   );
                          //   break;
                          default:
                            break;
                        }
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return 20.verticalSpace;
                  },
                ),
              ),
            ),
          ],
        );
        // return ListView.separated(
        //   reverse: true,
        //   shrinkWrap: true,
        //   itemCount: logic.messages.length,
        //   padding: const EdgeInsets.all(20),
        //   controller: logic.scrollController,
        //   physics: !logic.hasScroll
        //       ? const NeverScrollableScrollPhysics()
        //       : null,
        //   itemBuilder: (context, index) {
        //     final Message message = logic.messages[index];
        //     return ChatMessageItem(
        //       index: index,
        //       message: message,
        //       isSelectMode: isSelectMode,
        //       onTapMulti: () {
        //         isSelectMode = !isSelectMode;
        //         setState(() {});
        //       },
        //       onTapContent: () {
        //         // switch (message.kind) {
        //         //   case MsgKind.image:
        //         //     ImageMessageUI imageMessage = message as ImageMessageUI;
        //         //     Get.toNamed(
        //         //       AppRoutes.previewImage,
        //         //       arguments: {
        //         //         "hero": message.heroKey,
        //         //         "source": imageMessage.source,
        //         //       },
        //         //     );
        //         //     break;
        //         //   case MsgKind.video:
        //         //     VideoMessageUI videoMessage = message as VideoMessageUI;
        //         //     Get.toNamed(
        //         //       AppRoutes.previewVideo,
        //         //       arguments: {
        //         //         "source": videoMessage.source,
        //         //       },
        //         //     );
        //         //     break;
        //         // }
        //       },
        //     );
        //   },
        //   separatorBuilder: (BuildContext context, int index) {
        //     return 20.verticalSpace;
        //   },
        // );
      },
    );
    // return Container(
    //   color: Colors.amber,
    //   alignment: Alignment.topCenter,
    //   child: ListView.builder(
    //     itemCount: 10,
    //     reverse: true,
    //     shrinkWrap: true,
    //     padding: EdgeInsets.zero,
    //     physics: const BouncingScrollPhysics(),
    //     itemBuilder: (context, index) {
    //       return Text("Data$index");
    //     },
    //   ),
    // );

    // return Align(
    //   alignment: Alignment.topCenter,
    //   child: Scrollbar(
    //     controller: _scrollController,
    //     child: CustomScrollView(
    //       reverse: true,
    //       shrinkWrap: true,
    //       controller: _scrollController,
    //       physics: const BouncingScrollPhysics(),
    //       slivers: [
    //         SliverList.separated(
    //           itemCount: 20,
    //           itemBuilder: (context, index) {
    //             return ChatMessageItem(
    //               index: index,
    //               isSend: index % 2 == 0,
    //               isSelectMode: isSelectMode,
    //             );
    //           },
    //           separatorBuilder: (BuildContext context, int index) {
    //             return 20.verticalSpace;
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
