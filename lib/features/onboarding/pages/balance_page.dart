import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/router/app_router.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

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
                  "Qual o seu saldo inicial em caixa?",
                  style: textTheme.titleSmall,
                ),
                TextFormField(
                  style: const TextStyle(
                    fontSize: AppSizes.s09,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(.2)),
                    hintText: "R\$ 100,00",
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
              onTap: () => Navigator.of(context).pushNamed(AppRouter.onboardingFinishPage),
            ),
          )
        ],
      ),
    );
  }
}
