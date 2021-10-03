import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressInput extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subTitle;
  final VoidCallback? onPress;
  const AddressInput(
      {Key? key, this.icon, this.title, this.subTitle, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.greenAccent,
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: GoogleFonts.raleway(fontSize: 16.0, color: Colors.grey),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                subTitle!,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.raleway(
                    textStyle:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
              )
            ],
          )
        ],
      ),
    );
  }
}
