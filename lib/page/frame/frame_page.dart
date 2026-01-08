import 'package:almaren_desktop/page/chats/chats_logic.dart';
import 'package:almaren_desktop/page/chats/chats_page.dart';
import 'package:almaren_desktop/page/frame/widget/menu_item.dart';
import 'package:almaren_desktop/theme/dimensions.dart';
import 'package:almaren_desktop/widgets/avatar_widget.dart';
import 'package:almaren_desktop/widgets/online_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.put(ChatsLogic());
    // Get.put(ContactsLogic());
    // Get.put(SettingsLogic());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white60,
      //backgroundColor: const Color.fromRGBO(255, 255, 255, 0.85),
      body: _buildBody(),
    );
  }

  /// Body 左侧为菜单栏
  /// 右侧为内容区域
  Widget _buildBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Row(
          children: [
            _buildLeftMenu(),
            VerticalDivider(width: 1),
            Expanded(child: _buildContent()),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: 30,
          child: WindowCaption(),
        ),
      ],
    );
  }

  /// 左侧菜单
  Widget _buildLeftMenu() {
    return Container(
      width: 64,
      color: const Color.fromRGBO(255, 255, 255, 0.95),
      child: Stack(
        fit: StackFit.expand,
        children: [
          DragToMoveArea(
            child: SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     vertical: 10,
                //     horizontal: 8,
                //   ),
                //   child: Text("Almaren",style: TextStyle(fontSize: 10),),
                // ),
                Center(
                  child: ClipRRect(
                    borderRadius: Dimensions.borderRadiusSmall,
                    child: OnlineBoxWidget(
                      online: true,
                      child: AvatarWidget(
                        avatar: "assets/images/avatar/1.jpg",
                      ),
                    ),
                  ),
                ),

                MenuItem(
                  active: _pageIndex == 0,
                  text: "Chats",
                  icon: "assets/svgs/frame/frame_chat.svg",
                  activeIcon: "assets/svgs/frame/frame_chat_active.svg",
                  onTap: () {
                    setState(() {
                      _pageIndex = 0;
                    });
                  },
                ),

                MenuItem(
                  active: _pageIndex == 1,
                  text: "Contacts",
                  icon: "assets/svgs/frame/frame_contacts.svg",
                  activeIcon: "assets/svgs/frame/frame_contacts_active.svg",
                  onTap: () {
                    setState(() {
                      _pageIndex = 1;
                    });
                  },
                ),

                Spacer(),

                MenuItem(
                  active: _pageIndex == 2,
                  text: "Settings",
                  icon: "assets/svgs/frame/frame_settings.svg",
                  activeIcon: "assets/svgs/frame/frame_settings_active.svg",
                  onTap: () {
                    setState(() {
                      _pageIndex = 2;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 右侧内容
  Widget _buildContent() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xFFEDEDED),
      ),
      child: IndexedStack(
        index: _pageIndex,
        children: [
          const ChatsPage(),
          Text("Contacts"),
          Text("Settings"),
        ],
      ),
    );
  }
}
