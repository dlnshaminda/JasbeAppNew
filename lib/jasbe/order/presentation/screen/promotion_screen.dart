import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jasbe/common/functions.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  final promocodeContrller = TextEditingController();

  InputDecoration getInputDecoration(BuildContext context, String hint,
      {Widget? prefix, Widget? suffix, double? radius}) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
        borderSide: BorderSide(color: context.borderColor));
    final focusBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
        borderSide: BorderSide(color: context.borderColor));

    return InputDecoration(
      fillColor: Colors.transparent,
      filled: true,
      isDense: false,
      hintText: hint,
      contentPadding:
          const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
      hintStyle: TextStyle(color: context.secondaryTextColor, fontSize: 13),
      enabledBorder: border,
      focusedBorder: focusBorder,
      border: border,
      prefixIcon: prefix,
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PROMOS"),
        centerTitle: true,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Promo Code Input
              TextFormField(
                controller: promocodeContrller,
                cursorColor: context.foregroundColor,
                cursorWidth: 1.2,
                decoration: getInputDecoration(
                    context, "Input code voucher here",
                    radius: 25,
                    suffix: SizedBox(
                      width: context.screenWidth * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: context.errorColor,
                                  minimumSize:
                                      const Size(double.minPositive, 30),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: const Text(
                                "USE",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              onPressed: () {
                                toast(promocodeContrller.text);
                              },
                            ),
                          )
                        ],
                      ),
                    )),
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.newPassword],
              ),

              placeHold(0, 30),

              // Promo Card Sample
              _PromoCard(
                  offerName: "30% minium spend \$45",
                  expiredDate: DateTime(
                      2023, DateTime.now().month, DateTime.now().day + 3),
                  thumbnail: context.assets.americanoCoffee,
                  onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard(
      {super.key,
      required this.offerName,
      required this.expiredDate,
      required this.thumbnail,
      this.onTap});

  final String offerName;
  final DateTime expiredDate;
  final String thumbnail;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        highlightColor: Colors.black12,
        child: CouponCard(
          curvePosition: 130,
          curveRadius: 30,
          borderRadius: 10,
          width: context.screenWidth * 0.9,
          height: 195,
          border: BorderSide(color: context.primary),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          firstChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(thumbnail),
                  radius: 25,
                  backgroundColor: context.surfaceColor,
                ),
                placeHold(0, 10),
                Text(
                  offerName,
                  textScaleFactor: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                placeHold(0, 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.alarm_on, color: context.errorColor, size: 15),
                    placeHold(5, 0),
                    Text(
                      "Valid until ${DateFormat("dd MMM yyy").format(DateTime.now())}",
                      textScaleFactor: 0.9,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: context.errorColor),
                    ),
                  ],
                ),
                placeHold(0, 10),
              ],
            ),
          ),
          secondChild: Column(
            children: [
              Separator(color: context.primary),
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: context.secondaryTextColor,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    minimumSize: const Size(0, 35),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Terms & Condition",
                    textScaleFactor: 1.0,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Separator extends StatelessWidget {
  const Separator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
