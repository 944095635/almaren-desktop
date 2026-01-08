import 'package:almaren_desktop/models/chat.dart';
import 'package:almaren_desktop/page/chats/chats_item.dart';
import 'package:almaren_desktop/page/chats/chats_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/state_manager.dart';

class ChatsPage extends GetView<ChatsLogic> {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChatsLogic>(
        builder: (controller) {
          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildChatList(),
        Spacer(),
      ],
    );
  }

  Widget _buildChatList() {
    return Container(
      width: 240,
      color: Color(0xFFF7F7F7),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 20,
                bottom: 10,
              ),
              child: TextField(
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 10, right: 4),
                    child: SvgPicture.asset(
                      "assets/svgs/search.svg",
                      width: 14,
                      height: 14,
                      color: Colors.black38,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(maxWidth: 35),
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: controller.chats.length,
            itemBuilder: (context, index) {
              Chat chat = controller.chats[index];
              return ChatsItem(
                chat: chat,
                onTap: () {
                  for (Chat element in controller.chats) {
                    element.active = false;
                  }
                  chat.active = true;
                  controller.update();
                  controller.onTapChat(chat);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
