import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInput extends StatefulWidget {
  TextInput({
    super.key,
    required this.onChange,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.isHidden = false,
  });
  TextEditingController controller = TextEditingController();
  final String label;
  final IconData icon;
  final String hint;
  Function(String) onChange;
  bool? isHidden;
  IconData iconPass = Icons.remove_red_eye;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isHidden!,
      onChanged: widget.onChange,
      validator: (value) {
        if (widget.hint.endsWith('xxx')) {
          if (value!.isEmpty) {
            return 'required field';
          }
        } else {
          if (value!.isEmpty) {
            return 'required field';
          } else if (!isEmail(value)) {
            return "Check your email";
          }
        }
        return null;
      },
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.hint.contains('xxx')
            ? IconButton(
                icon: widget.isHidden == false
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    if (widget.isHidden == true) {
                      widget.isHidden = false;
                    } else {
                      widget.isHidden = true;
                    }
                  });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.blueAccent,
            )),
        hintText: widget.hint,
        hintStyle: const TextStyle(
          fontSize: 18,
        ),
        label: Row(
          children: [
            Icon(widget.icon),
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 3,
              color: Colors.blueAccent,
            )),
      ),
    );
  }

  bool isEmail(String email) {
    String emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(emailPattern);

    return regExp.hasMatch(email);
  }
}
