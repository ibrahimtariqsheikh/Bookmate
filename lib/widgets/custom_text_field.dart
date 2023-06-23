import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
required this.title,
    required this.hintText,
    this.obscureText = false,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.passwordSuffix,
    this.onFieldSubmitted, this.keyboardType,
  }) : super(key: key);

  final String hintText;
  final String title;
  final bool obscureText;
final TextInputType? keyboardType;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final int? maxLength;
  final bool? passwordSuffix;
  final String? Function(String?)? validator;
  final void Function(String?)? onFieldSubmitted;
  final TextEditingController? controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;

  bool hidePassword = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.passwordSuffix != null) {
      hidePassword = !widget.passwordSuffix!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyLarge,
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryContainer,
                width: 2,
              ),
            ),
            child: TextFormField(
              onChanged: (text) {},
keyboardType: (widget.keyboardType!=null)?TextInputType.emailAddress:widget.keyboardType,
              style: Theme.of(context).textTheme.bodySmall,
              controller: _controller,
              validator: widget.validator ??
                  (value) {
                    return null;
                  },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                ),
                errorStyle: GoogleFonts.dmSans(
                  textStyle: Theme.of(context).textTheme.headlineSmall!,
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                errorMaxLines: 3,
                contentPadding: const EdgeInsets.all(10),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: widget.prefixIcon,
                suffixIcon:
                    (widget.suffixIcon == null && widget.passwordSuffix == true)
                        ? IconButton(
                            icon: (hidePassword == false)
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          )
                        : widget.suffixIcon,
              ),
              obscureText:
                  (widget.obscureText && hidePassword == false) ? true : false,
              onFieldSubmitted: widget.onFieldSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
