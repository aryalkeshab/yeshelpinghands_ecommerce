import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final double? height;
  final double? width;
  final Color? color;
  final Color? labelColor;
  final FontWeight? labelWeight;
  final VoidCallback onPressed;

  const PrimaryButton({
    Key? key,
    required this.label,
    this.height,
    this.width,
    this.color,
    this.labelColor,
    this.labelWeight,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color ?? Theme.of(context).primaryColor,
        minimumSize: Size(width ?? double.maxFinite, height ?? 50),
      ),
      onPressed: onPressed,
      child: Text(label,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: labelColor ?? Theme.of(context).scaffoldBackgroundColor,
              fontWeight: labelWeight)),
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final double? height;
  final VoidCallback onPressed;
  final bool? isSmallButton;

  const PrimaryTextButton({
    Key? key,
    required this.label,
    this.height,
    required this.onPressed,
    this.labelColor,
    this.isSmallButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        label,
        style: isSmallButton!
            ? Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: labelColor ?? Theme.of(context).primaryColor)
            : Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: labelColor ?? Theme.of(context).primaryColor),
      ),
    );
  }
}

class PrimaryOutlinedButton extends StatelessWidget {
  double? width;
  double? height;
  Color? borderColor;
  VoidCallback onPressed;
  double? radius;
  Widget? loadingWidget;
  String title;
  Color? titleColor;
  Widget? icon;
  Color? iconColor;
  double? iconSize;

  PrimaryOutlinedButton(
      {Key? key,
      this.radius,
      this.width,
      this.iconSize,
      this.borderColor,
      this.loadingWidget,
      this.icon,
      this.iconColor,
      this.height,
      this.titleColor,
      required this.onPressed,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: borderColor ?? Theme.of(context).primaryColor,
        elevation: 0,
        minimumSize: Size(width ?? double.infinity, height ?? 40.0),
        side: BorderSide(
          width: 1,
          color: borderColor ?? Theme.of(context).primaryColor,
          style: BorderStyle.solid,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 4)),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: loadingWidget ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SizedBox(
                    width: iconSize ?? 15,
                    child: icon,
                  ),
                ),
              Text(title,
                  style: TextStyle(
                      color: borderColor ?? Theme.of(context).primaryColor)),
            ],
          ),
    );
  }
}
