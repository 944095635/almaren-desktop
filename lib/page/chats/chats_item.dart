import 'package:almaren_desktop/models/chat.dart';
import 'package:almaren_desktop/theme/colors.dart';
import 'package:almaren_desktop/theme/dimensions.dart';
import 'package:almaren_desktop/widgets/avatar_widget.dart';
import 'package:almaren_desktop/widgets/count_box_widget.dart';
import 'package:almaren_desktop/widgets/online_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled/size_extension.dart';

/// 会话列表 - 子项
class ChatsItem extends StatelessWidget {
  const ChatsItem({
    super.key,
    this.active = false,
    required this.chat,
    required this.onTap,
  });

  final Chat chat;

  final Function() onTap;

  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: active ? Color(0xFFDEDEDE) : null,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: Dimensions.borderRadiusSmall,
              child: OnlineBoxWidget(
                online: chat.online,
                child: AvatarWidget(
                  avatar: chat.portrait,
                  size: 32,
                ),
              ),
            ),

            /// 昵称 和 消息内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    maxLines: 1,
                    style: TextStyle(fontSize: 13),
                  ),
                  2.verticalSpace,
                  Text(
                    chat.msg ?? "",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColors.hintColor,
                    ),
                  ),
                ],
              ),
            ),

            /// 时间和未读消息数量
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.timestamp ?? "",
                  style: TextStyle(fontSize: 11),
                ),
                2.verticalSpace,
                // 显示未读消息数量
                if (chat.unread != 0) ...{
                  CountBoxWidget(
                    count: chat.unread,
                  ),
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}
