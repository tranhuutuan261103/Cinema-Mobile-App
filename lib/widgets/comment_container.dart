import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

import '../constants/colors.dart';
import '../utils/datetime_helper.dart';

class CommentContainer extends StatelessWidget {
  final bool hasSeparator;
  const CommentContainer({super.key, this.hasSeparator = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: hasSeparator ? Colors.grey[300]! : Colors.transparent,
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?img=1'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nguyen Van A',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      DatetimeHelper.getFormattedDate(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: colorPrimary,
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  '8/10 - Đáng xem',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const ExpandableText(
              'Ban tổ chức cuộc thi UniHack 2024 xin chân thành cảm ơn bạn vì đã dành thời gian tham gia sự kiện Demo Day - Chung kết cuộc thi UniHack 2024. Sự quan tâm và ủng hộ của bạn chính là động lực to lớn giúp chúng mình tổ chức thành công cuộc thi năm nay. Để bày tỏ sự trân trọng, chúng mình gửi tặng bạn Voucher ELSA Pro 3 tháng trị giá 50.000 đồng đến từ Nhà tài trợ Học bổng',
              style: TextStyle(
                fontSize: 14,
                height: 1.2,
              ),
              maxLines: 3,
              animation: true,
              collapseOnTextTap: true,
              expandText: 'xem thêm',
              collapseText: 'thu gọn',
              linkColor: colorPrimary,
              linkStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thumb_up,
                          color: colorPrimary,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '108',
                          style: TextStyle(
                            fontSize: 14,
                            color: colorPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.comment,
                          color: colorPrimary,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '43',
                          style: TextStyle(
                            fontSize: 14,
                            color: colorPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
