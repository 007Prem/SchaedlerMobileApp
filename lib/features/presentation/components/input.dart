import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String? hintText;
  final String? label;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final void Function(bool hasFocus)? focusListener;
  final Widget? suffixIcon;
  final String? errorMessage; // Added errorMessage parameter

  const Input({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.keyboardType,
    this.onEditingComplete,
    this.onTap,
    this.onTapOutside,
    this.textDirection,
    this.textInputAction,
    this.label,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.focusListener,
    this.suffixIcon,
    this.errorMessage, // Added errorMessage parameter
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late FocusNode _focusNode;
  late ScrollController _scrollController;

  void _setState() {
    setState(() {});
  }

  void _resetScroll() {
    if (!_focusNode.hasFocus) {
      _scrollController.jumpTo(0);
      setState(() {});
    }
  }

  void requestFocus() {
    _focusNode.requestFocus();
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(_setState);

    _scrollController = ScrollController();
    _focusNode.addListener(_resetScroll);

    if (widget.focusListener != null) {
      _focusNode.addListener(() {
        widget.focusListener!(_focusNode.hasFocus);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_setState);
    _focusNode.removeListener(_resetScroll);
    _focusNode.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void _handleChange(String value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppStyle.inputLabelGap),
            child: Text(
              widget.label!,
              style: OptiTextStyles.body,
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppStyle.inputDropShadowSpreadRadius,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppStyle.borderRadius),
            boxShadow: _focusNode.hasFocus
                ? const [
                    BoxShadow(
                      color: AppStyle.inputDropShadowColor,
                      spreadRadius: AppStyle.inputDropShadowSpreadRadius,
                    ),
                  ]
                : null,
          ),
          child: TextField(
            scrollController: _scrollController,
            onChanged: _handleChange,
            onSubmitted: widget.onSubmitted,
            controller: widget.controller,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            onEditingComplete: widget.onEditingComplete,
            onTap: widget.onTap,
            onTapOutside: widget.onTapOutside,
            style: OptiTextStyles.body,
            textAlign: widget.textAlign,
            textDirection: widget.textDirection,
            textInputAction: widget.textInputAction,
            focusNode: _focusNode,
            cursorColor: AppStyle.neutral990,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: OptiTextStyles.body.copyWith(
                color: AppStyle.neutral500,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppStyle.defaultHorizontalPadding,
                vertical: AppStyle.defaultVerticalPadding,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppStyle.borderRadius,
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppStyle.borderRadius,
                ),
                borderSide: const BorderSide(
                  color: AppStyle.primary500,
                ),
              ),
              filled: true,
              fillColor: _focusNode.hasFocus
                  ? AppStyle.neutral00
                  : AppStyle.neutral100,
              suffixIcon: _focusNode.hasFocus ? widget.suffixIcon : null,
            ),
          ),
        ),
        if (widget.errorMessage != null && widget.errorMessage != "")
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              widget.errorMessage ?? "",
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
