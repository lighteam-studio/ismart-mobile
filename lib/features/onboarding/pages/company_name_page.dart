import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/resources/app_sizes.dart';

class CompanyNamePage extends StatelessWidget {
  const CompanyNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    return Form(
      child: Column(
        children: [
          Expanded(
            //
            // Form
            child: ListView(
              padding: const EdgeInsets.all(AppSizes.s06),
              children: [
                Text(
                  "Qual o nome da sua loja?",
                  style: textTheme.titleSmall,
                ),
                TextFormField(
                  style: const TextStyle(
                    fontSize: AppSizes.s09,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(.2)),
                    hintText: "Ex.: Happy Shop",
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.s06),
            child: LtPrimaryButton(
              label: "Continuar",
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
