import 'package:flutter/material.dart';

//import '../../student/views/utils.dart';

class DropDownField extends StatefulWidget {
  final List<String> values;
  final void Function(int) onChanged;
  final String? label;
  final String? hint;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool enabled;
  final String? selection;
  final String? Function(String?)? validator;
  final bool isSmall;

  const DropDownField(
      {Key? key,
      required this.values,
      required this.onChanged,
      this.label,
      this.decoration,
      this.style,
      this.selection,
      this.enabled = true,
      this.validator,
      this.isSmall = false,
      this.hint})
      : super(key: key);

  @override
  _DropDownFieldState createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  String? selection;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        selection = widget.selection;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // selection ??= widget.values.isNotEmpty ? widget.values[0] : "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              widget.label!,
              //style: Util.normalTextBold(context),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                  icon: const Icon(Icons.expand_more),
                  validator: widget.validator,
                  decoration: widget.decoration ??
                      InputDecoration(
                        filled: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                  style: widget.style,
                  hint: Text(widget.hint ?? "Select"),
                  value: selection,
                  onChanged: widget.enabled
                      ? (value) {
                          if (value != null) {
                            setState(() {
                              selection = value;
                            });
                            widget.onChanged(widget.values.indexOf(value));
                          }
                        }
                      : null,
                  items: widget.values
                      .map((String type) => DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              type,
                              style: widget.isSmall
                                  ? const TextStyle(fontSize: 12)
                                  : null,
                            ),
                          ))
                      .toList()),
            ),
          ],
        ),
      ],
    );
  }
}
