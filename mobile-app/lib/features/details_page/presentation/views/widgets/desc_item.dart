import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_holder_items/h_desc_item.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_holder_items/v_desc_item.dart';
import 'package:flutter/material.dart';

class DescItem extends StatelessWidget {
  const DescItem({
    super.key,
    required this.head,
    required this.tail,
    this.isH = true,
  });
  final String head, tail;
  final bool isH;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child:
          isH
              ? HDescItem(tail: tail, head: head)
              : VDescItem(head: head, tail: tail),
    );
  }
}
