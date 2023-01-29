import 'package:tmdb/utils/imports.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    required this.suffixIcon,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final Widget suffixIcon;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        // color: kBlackColor,
        color: Colors.white,
        boxShadow: kNeuShadow,
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        cursorColor: kDeepOrangeColor,
        style: const TextStyle(
          fontSize: 14,
          color: kBlackColor,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: kHintColor,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: kPrimaryColor,
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.only(right: 20, top: 15),
          border: kSearchInputBorder,
          enabledBorder: kSearchInputBorder,
          focusedBorder: kSearchInputBorder,
          errorBorder: kSearchInputBorder,
          disabledBorder: kSearchInputBorder,
          focusedErrorBorder: kSearchInputBorder,
        ),
      ),
    );
  }
}
