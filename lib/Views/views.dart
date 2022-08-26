import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

class MyButton extends StatelessWidget {
  String text;
  Color? color;
  Color? textColor;
  Color borderColor;
  VoidCallback onPress;
  double height, circularRadius;
  Widget? child;
  bool isEnabled;

  MyButton(
      {this.text = "No text given",
      required this.onPress,
      this.color,
      this.borderColor = const Color(0x1d2b3990),
      this.textColor,
      this.height = 52,
      this.circularRadius = 15,
      this.child,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    Color disableColor = Color(0x1d2b3990);
    Color normalColor = Color(0xff504763);
    return MaterialButton(
      color: color ?? normalColor,
      height: height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularRadius),
        side: BorderSide(
            color: color ??
                (isEnabled ? normalColor : borderColor)),
      ),
      onPressed: isEnabled ? onPress : null,
      disabledColor: disableColor,
      textColor: Colors.white,
      child: child ??
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: textColor ?? (isEnabled ? Colors.white : Colors.black87),
              fontFamily: 'Gibson-SemiBold',
            ),
          ),
    );
  }
}

void toast(message) {
  if (message != null) {
    showToast(
      message,
      duration: Duration(seconds: 2),
      position: ToastPosition.bottom,
      backgroundColor: Colors.grey[800],
      radius: 5.0,
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
    );
  }
}

void NotImplemented() {
  toast('Not Implemented Yet');
}

class EditText extends StatelessWidget {
  Function(String?)? onChange, onSaved;
  String? Function(String?)? validator;
  final String? hintText, errorText, prefixIcon, suffixIcon, fontFamily;
  IconData? icon, prefixiconData;
  bool setEnable, showBorder;
  bool obscure;
  bool isDropDown, isPassword;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  List<TextInputFormatter>? inputFormatter;
  FocusNode? currentFocus, nextFocus;
  BuildContext context;
  Function(String)? onFieldSubmitted;
  TextEditingController? controller;
  VoidCallback? suffixClick;
  int? maxLines, maxLength;

  EditText({
    required this.context,
    this.onChange,
    this.hintText,
    this.errorText,
    this.icon,
    this.prefixiconData,
    this.prefixIcon,
    this.suffixIcon,
    this.fontFamily,
    this.onSaved,
    this.validator,
    this.setEnable = true,
    this.obscure = false,
    this.isDropDown = false,
    this.isPassword = false,
    this.showBorder = true,
    this.currentFocus,
    this.nextFocus,
    this.textInputAction,
    this.textInputType,
    this.inputFormatter,
    this.onFieldSubmitted,
    this.controller,
    this.suffixClick,
    this.maxLength,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return TextFormField(
      validator: validator,
//      autovalidate: true,
      controller: controller,
      enabled: setEnable,
      onChanged: onChange,
      onSaved: onSaved,
      maxLines: maxLines,
      maxLength: maxLength,

//      autofocus: true,
      focusNode: currentFocus,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      inputFormatters: inputFormatter,
      obscureText: obscure,
//      cursorColor: accentColor,
      style: TextStyle(
        height: 1.2,
        fontSize: 16,
        color: Colors.black,
        fontFamily: 'Gibson',
      ),
      textAlignVertical: TextAlignVertical.center,
      onFieldSubmitted: onFieldSubmitted ??
          (value) {
            _fieldFocusChange(currentFocus, nextFocus);
          },
      decoration: InputDecoration(
        isCollapsed:
            prefixIcon != null || prefixiconData != null || suffixIcon != null,
        // contentPadding: EdgeInsets.only(top: 5),
        hintText: hintText,
        filled: true,
        fillColor: Color(0xfff7f9ff),
        prefixStyle: TextStyle(color: Colors.blue, fontSize: 16),
        // labelStyle: TextStyle(color: Colors.black, fontSize: 16, height: 1.2),
        hintStyle: TextStyle(
            fontFamily: 'Gibson', color: Color(0xff78849e), fontSize: 16),
        suffixIcon: isPassword
            ? IconButton(
                splashColor: Colors.transparent,
                icon: Icon(icon),
                color: Color(0xff7c849c),
                onPressed: suffixClick,
              )
            : isDropDown
                ? SizedBox(
                    width: 0,
                    height: 15,
                    child: Image.asset(
                      suffixIcon!,
                      scale: 2.5,
                    ),
                  )
                : suffixIcon != null
                    ? GestureDetector(
                        onTap: suffixClick,
                        child: Image.asset(
                          suffixIcon!,
                          scale: 2.5,
                          color: Color(0xff78849e),
                        ),
                      )
                    : null,
        prefixIcon: prefixiconData != null
            ? Icon(
                prefixiconData,
                color: Color(0xff838EA9),
                size: 20,
              )
            : prefixIcon != null
                ? Row(
          mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 17,),
                    Image.asset(
                        prefixIcon!,
                        scale: 2.5,
                      ),
                    // Icon(Icons.add),
                  ],
                )
                : null,
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff7f9ff)),
            borderRadius: BorderRadius.circular(18)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff7f9ff)),
            borderRadius: BorderRadius.circular(18)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff7f9ff)),
            borderRadius: BorderRadius.circular(18)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff7f9ff)),
            borderRadius: BorderRadius.circular(18)),
      ),
    );
  }

  _fieldFocusChange(
      /*BuildContext context,*/ FocusNode? currentFocus, FocusNode? nextFocus) {
    currentFocus?.unfocus();
    if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
  }
}

class LabeledEditText extends StatelessWidget {
  Function(String?)? onChange, onSaved;
  String? Function(String?)? validator;
  final String? labelText, hintText, value, prefixText;
  Widget? prefixIcon;
  bool setEnable, obscure;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  List<TextInputFormatter>? inputFormatter;
  FocusNode? currentFocus, nextFocus;
  BuildContext context;
  Function(String)? onFieldSubmitted;
  TextEditingController? controller;
  int? maxLength;
  TextAlign textAlign;
  bool autoValidate;
  Widget? prefix;

  // IconData icon, prefixiconData;

  LabeledEditText({
    required this.context,
    this.onChange,
    this.labelText,
    this.hintText,
    this.value,
    this.prefixText,
    this.onSaved,
    this.validator,
    this.obscure = false,
    this.setEnable = true,
    this.autoValidate = false,
    this.currentFocus,
    this.nextFocus,
    this.textInputAction,
    this.textInputType,
    this.inputFormatter,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.prefix,
    this.onFieldSubmitted,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    context = context;
    return TextFormField(
      validator: validator,
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      // autovalidate: autoValidate,
      controller: controller,
      enabled: setEnable,
      onChanged: onChange,
      onSaved: onSaved,
      obscureText: obscure,
//      maxLines: 1,
//      autofocus: true,
      focusNode: currentFocus,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      inputFormatters: inputFormatter,
      textAlign: textAlign,
      maxLength: maxLength,
//      cursorColor: accentColor,
      style: TextStyle(
//        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Gibson',
      ),
      onFieldSubmitted: onFieldSubmitted ??
          (value) {
            _fieldFocusChange(currentFocus, nextFocus);
          },
      initialValue: value,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefix,
        prefixText: prefixText,
        filled: true,
        fillColor: Color(0xfff7f9ff),
        prefixStyle: TextStyle(color: Colors.blue, fontSize: 16),
        labelStyle: TextStyle(color: Colors.black, fontSize: 16, height: 1.2),
        hintStyle: TextStyle(color: Color(0xff78849e), fontSize: 16),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff7f9ff)),
            borderRadius: BorderRadius.circular(18)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff7f9ff)),
            borderRadius: BorderRadius.circular(18)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff7f9ff)),
            borderRadius: BorderRadius.circular(18)),
      ),
    );
  }

  _fieldFocusChange(
      /*BuildContext context,*/ FocusNode? currentFocus, FocusNode? nextFocus) {
    currentFocus?.unfocus();
    if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
  }
}

class RadioGroup extends StatefulWidget {
  String? title;
  List<String> list;
  Color color;
  String? initValue;
  Function(String)? onChanged;

  RadioGroup(
      {this.title,
      required this.list,
      this.initValue,
      this.color = Colors.black,
      this.onChanged});

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (String item in widget.list)
          _myRadioButton(
            title: item,
            value: item,
//          selected: item==_groupValue?true:false,
            onChanged: (newValue) =>
                newValue ??
                setState(() {
                  widget.initValue = newValue;
                  widget.onChanged ?? widget.onChanged!(newValue!);
                }),
          ),
      ],
    );
  }

  Widget _myRadioButton(
      {required String title,
      required String value,
      bool selected = false,
      Function(String?)? onChanged}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.black, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.black),
      child: RadioListTile(
        activeColor: widget.color,
        value: value,
        groupValue: widget.initValue,
        selected: selected,
        onChanged: onChanged,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        label: Text(
          isSelected ? "Interested" : "Not Interested",
          style: TextStyle(color: Colors.white),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            isSelected = selected;
          });
        },
      ),
    );
  }
}
