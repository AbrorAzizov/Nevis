import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int count;
  final int productId;
  final void Function(int productId, int newCount) onCountChanged;

  const CounterWidget({
    super.key,
    required this.count,
    required this.productId,
    required this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: Colors.grey.shade700),
            onPressed: () {
              if (count > 1) {
                onCountChanged(productId, count - 1);
              }
            },
            splashRadius: 20,
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.grey.shade700),
            onPressed: () {
              onCountChanged(productId, count + 1);
            },
            splashRadius: 20,
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
