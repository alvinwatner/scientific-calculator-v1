import 'package:stacked/stacked.dart';

class ErrorAlertDialogModel extends BaseViewModel {
  bool _isVisible = true;
  bool get isVisible => _isVisible;

  void dismiss() {
    _isVisible = false;
    notifyListeners();
  }
}
