import 'package:flutter/material.dart';
import 'package:ismart/components/lt_file_picker.dart';
import 'package:ismart/components/lt_hollow_button.dart';
import 'package:ismart/components/lt_primary_button.dart';
import 'package:ismart/components/lt_text_form_field.dart';
import 'package:ismart/resources/app_sizes.dart';

class FirstProductPage extends StatelessWidget {
  const FirstProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s06),
            children: [
              Text(
                "Cadastre seu primeiro produto, é super fácil 😁",
                style: textTheme.titleSmall,
              ),
              const SizedBox(height: AppSizes.s06),

              // Imagem do produto
              const Center(child: LtFilePicker()),
              const SizedBox(height: AppSizes.s06),

              // Categoria
              const LtTextFormField(
                label: "Categoria",
                placeholder: "Selecione uma categoria",
              ),
              const SizedBox(height: AppSizes.s04),

              // Nome do Produto
              const LtTextFormField(
                label: "Nome",
                placeholder: "Nome do produto",
              ),
              const SizedBox(height: AppSizes.s04),

              // Marca do produto
              const LtTextFormField(
                label: "Marca",
                placeholder: "Marca do produto",
              ),
              const SizedBox(height: AppSizes.s04),

              // Preço de venda
              const LtTextFormField(
                label: "Preço de venda",
                placeholder: "Marca do produto",
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSizes.s04),
        // Select current interactions
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.s06,
          ),
          child: LtPrimaryButton(
            label: "Continuar",
            onTap: () {},
          ),
        ),

        // Skip this step
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s06),
          child: LtHollowButton(
            label: "Pular",
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
