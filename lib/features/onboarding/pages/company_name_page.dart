import 'package:flutter/material.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/features/onboarding/providers/company_name_form.dart';
import 'package:ismart/features/onboarding/providers/onboarding_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class CompanyNamePage extends StatelessWidget {
  const CompanyNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    OnboardingProvider onboardingProvider = Provider.of(context);

    return ChangeNotifierProvider.value(
      value: onboardingProvider.companyNameForm,
      builder: (context, child) {
        CompanyNameForm form = Provider.of(context);

        return Form(
          key: form.shopNameForm,
          autovalidateMode: form.validateOnInput
              ? AutovalidateMode.onUserInteraction //
              : AutovalidateMode.onUserInteraction,
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
                      controller: form.shopNameController,
                      minLines: 1,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: AppSizes.s09,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(.2)),
                        hintText: "Ex.: Happy Shop",
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (form.shopNameController.text.isEmpty) {
                          return "Este campo é obrigatório";
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSizes.s06),
                child: LtPrimaryButton(
                  label: "Continuar",
                  onTap: () => onboardingProvider.setCompanyName(context),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
