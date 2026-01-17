import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Uihelper {
  static CustomImage({required String img}) {
    return Image.asset("assets/images/$img");
  }

  static CustomTextButton({
    required String text,
    required VoidCallback callback,
  }) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          callback();
        },
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  static TextButtonForm({
    required VoidCallback callback,
    required String text,
  }) {
    return TextButton(onPressed: () {}, child: Text(text));
  }

  static CutomTextFiled({
    /// named parameter
    required TextEditingController controller,
    required String text,
    final Widget? suffixicon,
    final Widget? preffixicon,
    required FocusNode? focusnode,
    required TextInputType textinputtype,
    required String? Function(String?)? validater,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.only(right: 20, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.blue,
      ),
      child: TextFormField(
        controller: controller,
        validator: validater,
        keyboardType: textinputtype,
        decoration: InputDecoration(
          suffix: suffixicon,
          prefixIcon: preffixicon,
          hintText: text,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
