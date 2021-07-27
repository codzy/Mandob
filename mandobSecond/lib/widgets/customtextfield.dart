import 'package:flutter/material.dart';
class CustomeFormField extends StatefulWidget {
  TextEditingController a;
  String errormsg;
  String hint;
  IconData m;
  TextInputType textInputType;
  bool isviv;
  Function function;
  CustomeFormField(
      this.a,
      this.isviv,
      this.errormsg,
      this.hint,
      this.m,
      this.textInputType,
      this.function
      );
  @override
  _CustomeFormFieldState createState() => _CustomeFormFieldState(
      this.a,
      this.isviv,
      this.errormsg,
      this.hint,
      this.m,
      this.textInputType,
      this.function
      );
}

class _CustomeFormFieldState extends State<CustomeFormField> {
Function function;
  TextEditingController a;
  String errormsg;
  String hint;
  IconData m;
  TextInputType textInputType;
  bool isviv;
   _CustomeFormFieldState(this.a, this.isviv, this.errormsg, this.hint, this.m,
      this.textInputType,this.function);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
       
     
      obscureText:
          textInputType == TextInputType.visiblePassword ? !isviv : false,
      controller: a,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: InputBorder.none,
          icon: Icon(
            m,
            color: Theme.of(context).iconTheme.color,
          ),
          hintText: hint,
          suffixIcon: textInputType == TextInputType.visiblePassword
              ? IconButton(
                  icon: Icon(isviv ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      print("dsf");
                      isviv = !isviv;
                    });
                  })
              : null),
      validator: (text) {
        if (!function(text)) {
           return errormsg;
        } else {
          return null;
        }
      },
    );
  }
}