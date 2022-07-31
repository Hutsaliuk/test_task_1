import 'package:flutter/material.dart';

/// Field with radio tiles elements.
/// That allows to made a validation.
///
/// Number of options and tiles title are depends on [items] property.
/// The [validatior] property allows you set the rule for validation.
///
///Example:
/// ```dart
///RadioFormField(
///  items: const [
///    Text('Man'),
///    Icon(Icons.woman),
///  ],
///  validatior: (value) =>
///      value == null ? "You haven't selected any option!" : null,
///),
/// ```
class RadioFormField extends StatefulWidget {
  const RadioFormField({
    Key? key,
    required this.items,
    required this.validatior,
    this.radioFormKey,
  })  : assert(items.length > 1),
        super(key: key);

  final List<Widget> items;
  final String? Function(int? value) validatior;
  final GlobalKey<FormFieldState>? radioFormKey;

  @override
  State<RadioFormField> createState() => _RadioFormFieldState();
}

class _RadioFormFieldState extends State<RadioFormField> {
  int? _currentSelectedIndex;

  final _cardBorderRadius = 15.0;
  final _radioSplashRadius = 0.0;

  @override
  Widget build(BuildContext context) {
    return FormField<int?>(
      key: widget.radioFormKey,
      validator: widget.validatior,
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_cardBorderRadius),
              ),
              clipBehavior: Clip.hardEdge,
              child: ListTile(
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: widget.items[index],
                ),
                trailing: Radio<int>(
                  splashRadius: _radioSplashRadius,
                  value: index,
                  groupValue: _currentSelectedIndex,
                  onChanged: (value) {
                    setState(() {
                      field.didChange(value);
                      _currentSelectedIndex = value;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    field.didChange(index);
                    _currentSelectedIndex = index;
                  });
                },
              ),
            ),
          ),
          field.hasError
              ? ErrorTextWidget(errorText: field.errorText ?? '')
              : Container(),
        ],
      ),
    );
  }
}

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({
    Key? key,
    required this.errorText,
  }) : super(key: key);

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        errorText,
        style: TextStyle(color: Theme.of(context).errorColor),
      ),
    );
  }
}
