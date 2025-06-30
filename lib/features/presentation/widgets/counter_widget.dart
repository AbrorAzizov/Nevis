import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nevis/features/domain/entities/product_entity.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';

class CounterWidget extends StatelessWidget {
  final int count;
  final ProductEntity product;
  final void Function(int productId, int newCount) onCountChanged;

  const CounterWidget({
    super.key,
    required this.count,
    required this.product,
    required this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    final productId = product.productId;

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
              if (productId == null) return;

              if (count > 1) {
                onCountChanged(productId, count - 1);
              } else {
                context
                    .read<CartScreenBloc>()
                    .add(DeleteProductFromCart(productId: productId));
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
              if (productId == null) return;

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
