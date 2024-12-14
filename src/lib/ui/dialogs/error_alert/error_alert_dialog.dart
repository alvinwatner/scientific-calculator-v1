import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:scientific_calc/ui/common/app_colors.dart';
import 'package:scientific_calc/ui/common/ui_helpers.dart';
import 'package:scientific_calc/ui/dialogs/error_alert/error_alert_dialog_model.dart';

class ErrorAlertDialog extends StackedView<ErrorAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ErrorAlertDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ErrorAlertDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            verticalSpaceMedium,
            Text(
              request.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: kcDarkGreyColor,
              ),
            ),
            verticalSpaceSmall,
            Text(
              request.description!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: kcMediumGrey,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(confirmed: true)),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ErrorAlertDialogModel viewModelBuilder(BuildContext context) =>
      ErrorAlertDialogModel();
}
