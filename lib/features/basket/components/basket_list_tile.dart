import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/core/enums/product_unit.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:transparent_image/transparent_image.dart';

class BasketListTile extends StatefulWidget {
  final ImageProvider? thumbnail;
  final String name;
  final String brand;
  final double unitPrice;
  final ProductUnit unit;
  final double amount;
  final double stock;
  final void Function() onRemove;
  final void Function(double value) onChangeAmount;

  const BasketListTile({
    required this.onRemove,
    this.thumbnail,
    required this.brand,
    required this.unitPrice,
    required this.unit,
    required this.amount,
    required this.stock,
    required this.onChangeAmount,
    required this.name,
    super.key,
  });

  @override
  State<BasketListTile> createState() => _BasketListTileState();
}

class _BasketListTileState extends State<BasketListTile> {
  late final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    decimalDigits: widget.unit == ProductUnit.kg ? 2 : 0,
    turnOffGrouping: true,
    symbol: "",
  );

  late final TextEditingController _lengthController =
      TextEditingController(text: _formatter.formatDouble(widget.amount))
        ..addListener(
          () {
            var amount = double.tryParse(_lengthController.text) ?? 0;

            if (amount > widget.stock) {
              _lengthController.text = _formatter.formatDouble(widget.stock);
              return;
            } else if (amount < 0) {
              _lengthController.text = _formatter.formatDouble(0);
              return;
            }

            widget.onChangeAmount(amount);
          },
        );

  void increment() {
    var amount = double.tryParse(_lengthController.text) ?? 0;

    if (amount < widget.stock) {
      var value = _formatter.formatDouble(amount + 1);
      _lengthController.text = value;
    }
  }

  void decrement() {
    var amount = double.tryParse(_lengthController.text) ?? 0;

    _lengthController.text = amount > 1 ? _formatter.formatDouble(amount - 1) : '0';
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var canDecrement = widget.amount > 0;
    var canIncrement = widget.amount < widget.stock;
    var totalPrice = (widget.unitPrice * widget.amount).toStringAsFixed(2);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.s05),
      padding: const EdgeInsets.all(AppSizes.s02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s03),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            blurRadius: AppSizes.s03,
            color: Colors.black.withOpacity(.08),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Product image
              Container(
                height: AppSizes.s14,
                width: AppSizes.s14,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.s05),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset.zero,
                      blurRadius: AppSizes.s03,
                      color: Colors.black.withOpacity(.08),
                    )
                  ],
                ),
                child: widget.thumbnail != null
                    ? FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: widget.thumbnail!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Image.asset(
                          AppIcons.bag,
                          width: AppSizes.s08,
                          color: colorScheme.onSurface.withOpacity(.1),
                        ),
                      ),
              ),
              const SizedBox(width: AppSizes.s02_5),

              // Product Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Product Name
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: AppSizes.s03_5,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                    ),

                    // Product brand
                    Text(
                      widget.brand,
                      style: TextStyle(
                        fontSize: AppSizes.s03,
                        color: colorScheme.onSurface.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 180),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSizes.s03),
                ),
                child: Row(
                  children: [
                    //
                    // Decrement product stock
                    LtIconButton(
                      icon: canDecrement ? AppIcons.circleMinus : AppIcons.trash,
                      color: canDecrement ? colorScheme.onSurface : colorScheme.error,
                      onPressed: () => canDecrement ? decrement() : widget.onRemove(),
                    ),

                    // Product quantity input
                    Expanded(
                      child: TextFormField(
                        controller: _lengthController,
                        inputFormatters: [
                          _formatter,
                        ],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          height: 1,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // Increment product quantity
                    Opacity(
                      opacity: canIncrement ? 1 : .2,
                      child: LtIconButton(
                        icon: AppIcons.circlePlus,
                        onPressed: canIncrement ? () => increment() : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.s01),

              // Product Unit
              Text(widget.unit.name),
              const SizedBox(width: AppSizes.s01),

              const Spacer(),

              // Prduct price
              Text(
                "€$totalPrice",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                  fontSize: AppSizes.s04_5,
                ),
                maxLines: 2,
              ),
            ],
          )
        ],
      ),
    );
  }
}
