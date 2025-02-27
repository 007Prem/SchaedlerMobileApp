import 'dart:io';

import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int min;
  final int max;
  final int step;
  final double arrowsWidth;
  final double arrowsHeight;
  final EdgeInsets contentPadding;
  final double borderWidth;
  final ValueChanged<int?>? onChanged;
  final ValueChanged<int?>? onSubmitted;
  final String? initialText;
  final bool shouldShowIncrementDecrementIcon;
  final void Function(bool hasFocus)? focusListener;
  final bool? isEnabled;
  final bool? showWarningHighlighted;

  const NumberTextField({
    super.key,
    this.initialText,
    this.shouldShowIncrementDecrementIcon = false,
    this.controller,
    this.focusNode,
    this.min = 1,
    this.max = 999,
    this.step = 1,
    this.arrowsWidth = 24,
    this.arrowsHeight = kMinInteractiveDimension,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.borderWidth = 2,
    this.onChanged,
    this.focusListener,
    this.isEnabled = true,
    this.onSubmitted,
    this.showWarningHighlighted = false,
  });

  @override
  State<StatefulWidget> createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _canGoUp = false;
  bool _canGoDown = false;
  bool _shouldShowIncrementDecrementIcon = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.text = widget.initialText ?? "1";
    _shouldShowIncrementDecrementIcon = widget.shouldShowIncrementDecrementIcon;
    _updateArrows(int.tryParse(_controller.text));
    _focusNode.addListener(_onFocusChange);
    if (widget.focusListener != null) {
      _focusNode.addListener(() {
        widget.focusListener!(_focusNode.hasFocus);
      });
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      if (Platform.isIOS) {
        _showDoneButton();
      }
    } else {
      _handleSubmitted(_controller.text);
      _removeOverlay();
    }
  }

  void _showDoneButton() {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 0,
        right: 0,
        child: Material(
          elevation: 4.0,
          color: Colors.grey[200],
          child: Container(
            height: 40.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _focusNode.unfocus(); // Dismiss the keyboard
                  },
                  child: Text(
                    LocalizationConstants.done.localized(),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void didUpdateWidget(covariant NumberTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller ?? _controller;
    }
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? _focusNode;
    }
    _controller.text = widget.initialText ?? _controller.text;
    _shouldShowIncrementDecrementIcon = widget.shouldShowIncrementDecrementIcon;
    _updateArrows(int.tryParse(_controller.text));
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          // Minus button
          if (_shouldShowIncrementDecrementIcon)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_canGoDown) {
                      _update(false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OptiAppColors.backgroundGray,
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ),
          // TextField
          Expanded(
            child: TextField(
              enabled: widget.isEnabled,
              controller: _controller,
              focusNode: _focusNode,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              maxLength: widget.max.toString().length +
                  (widget.min.isNegative ? 1 : 0),
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppStyle.textFieldDefaultHorizontalPadding,
                  vertical: AppStyle.defaultVerticalPadding,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppStyle.textFieldborderRadius,
                  ),
                  borderSide: widget.showWarningHighlighted!
                      ? const BorderSide(color: Color.fromARGB(255, 244, 0, 0))
                      : BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppStyle.textFieldborderRadius,
                  ),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppStyle.textFieldborderRadius,
                  ),
                  borderSide: const BorderSide(
                    color: AppStyle.neutral500,
                  ),
                ),
                filled: true,
                fillColor: _focusNode.hasFocus
                    ? AppStyle.neutral00
                    : AppStyle.neutral100,
              ),
              maxLines: 1,
              onTapOutside: (p0) => context.closeKeyboard(),
              onSubmitted: (value) {
                _handleSubmitted(value);
                _focusNode.unfocus();
              },
              onChanged: (value) {
                final intValue = int.tryParse(value);
                widget.onChanged?.call(intValue);
                _updateArrows(intValue);
              },
              inputFormatters: [
                _NumberTextInputFormatter(widget.min, widget.max)
              ],
            ),
          ),
          // Plus button
          if (_shouldShowIncrementDecrementIcon)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_canGoUp) {
                      _update(true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OptiAppColors.backgroundGray,
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ),
        ],
      );

  void _handleSubmitted(String value) {
    final intValue = int.tryParse(value);
    widget.onSubmitted?.call(intValue);
    _updateArrows(intValue);
  }

  void _update(bool up) {
    var intValue = int.tryParse(_controller.text);
    intValue == null
        ? intValue = 1
        : intValue += up ? widget.step : -widget.step;
    _controller.text = intValue.toString();
    widget.onSubmitted?.call(intValue); // Fire onChanged event
    _updateArrows(intValue);
  }

  void _updateArrows(int? value) {
    final canGoUp = value == null || value < widget.max;
    final canGoDown = value == null || value > widget.min;
    if (_canGoUp != canGoUp || _canGoDown != canGoDown) {
      setState(() {
        _canGoUp = canGoUp;
        _canGoDown = canGoDown;
      });
    }
  }
}

class _NumberTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  _NumberTextInputFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (const ['-', ''].contains(newValue.text)) {
      return newValue;
    }
    final intValue = int.tryParse(newValue.text);
    if (intValue == null) {
      return newValue;
    }
    if (intValue < min) {
      return newValue.copyWith(text: min.toString());
    }
    if (intValue > max) {
      return newValue.copyWith(text: max.toString());
    }
    return newValue.copyWith(text: intValue.toString());
  }
}
