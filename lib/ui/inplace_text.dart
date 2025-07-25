import 'package:flutter/material.dart';

class InplaceText extends StatefulWidget {
  final String? text;
  final Widget? label;
  final String? hintText;
  final bool autofocus;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final int? minLines;
  final int? maxLines;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const InplaceText({
    super.key,
    this.text,
    this.label,
    this.hintText,
    this.autofocus = true,
    this.onChanged,
    this.onSubmitted,
    this.minLines,
    this.maxLines,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
  });

  @override
  State<InplaceText> createState() => _InplaceTextState();
}

class _InplaceTextState extends State<InplaceText> {
  final _controller = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _isEditing
          ? Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                autofocus: widget.autofocus,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: widget.foregroundColor),
                  hintStyle: TextStyle(color: widget.foregroundColor),
                  iconColor: widget.foregroundColor,
                  suffixIconColor: widget.foregroundColor,
                  prefixIconColor: widget.foregroundColor,

                  label: widget.label,
                  hintText: widget.hintText,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                      widget.onSubmitted?.call(_controller.text);
                    },
                    icon: const Icon(Icons.save_rounded),
                  ),
                ),
                controller: _controller,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                onSubmitted: (value) {
                  widget.onSubmitted?.call(value);
                  setState(() {
                    _isEditing = false;
                  });
                },
                onChanged: widget.onChanged,
              ),
            )
          : InkWell(
              onTap: () {
                setState(() {
                  _isEditing = true;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.label ?? const SizedBox.shrink(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.text ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: widget.foregroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
