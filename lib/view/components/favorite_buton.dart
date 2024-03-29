import 'dart:math';

import 'package:bmi_calculator/controllers/bmi_controller.dart';
import 'package:bmi_calculator/controllers/favorite_controller.dart';
import 'package:bmi_calculator/models/bmi_favorite_model.dart';
import 'package:bmi_calculator/utils/colors.dart';
import 'package:bmi_calculator/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.bmi,
  });

  final BmiController bmi;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final bmiFavorite = BmiFavoriteModel(
            id: Random().nextInt(1000000).toString(),
            height: bmi.height,
            weight: bmi.weight,
            bmi: bmi.bmiValue,
            date: DateTime.now(),
            colorClassification: bmi.getResultColor(),
            classification: bmi.getResultString());

        try {
          await Provider.of<FavoriteController>(context, listen: false)
              .saveBmi(bmi: bmiFavorite);

          SnackbarUtils.showSnackBar(
              context: context, text: 'IMC salvo com sucesso.');
        } catch (e) {
          SnackbarUtils.showSnackBar(
              context: context, text: 'Falha ao salvar IMC.');
        }
      },
      backgroundColor: AppColors.primaryColor,
      child: const Icon(Icons.favorite),
    );
  }
}
