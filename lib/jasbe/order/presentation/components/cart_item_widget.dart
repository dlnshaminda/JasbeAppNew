import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jasbe/common/functions.dart';
import 'package:jasbe/jasbe/order/model/cart_item.dart';
import 'package:jasbe/main.dart';

class CartItemTile extends StatefulWidget {
  const CartItemTile({super.key, required this.cartItem,required this.onUpdated});

  final CartItem cartItem;
  final VoidCallback onUpdated;

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.cartItem.id),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: Center(
          child: GestureDetector(
            onTap: () {
              cartController.forceDelete(widget.cartItem);
            },
            child: Container(
              width: context.screenWidth * 0.2,
              height: context.screenHeight * 0.1,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                color: context.errorColor,
              ),
              child: const Icon(IconlyLight.delete, color: Colors.white),
            ),
          ),
        ),
        children: [],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: context.screenHeight * 0.1,
              width: context.screenHeight * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: Colors.lightBlueAccent.withOpacity(0.2),
                image: DecorationImage(image: AssetImage(widget.cartItem.item.image!), fit: BoxFit.contain),
              ),
            ),
            placeHold(10, 0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  placeHold(0, 4),
                  Text(widget.cartItem.item.name),
                  Text(
                    widget.cartItem.item.description,
                    textScaleFactor: 1.0,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: context.secondaryTextColor),
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      shape: const StadiumBorder(),
                      color: Colors.lightBlue.withOpacity(0.5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                    child: const Text("Small", textScaleFactor: 0.8),
                  ),
                  Text(
                    "\$ ${widget.cartItem.item.price}",
                    textScaleFactor: 1.5,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(side: BorderSide(color: context.borderColor)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        cartController.addItem(widget.cartItem);
                        setState(() {});
                        widget.onUpdated();
                      },
                      highlightColor: context.borderColor,
                      splashColor: context.borderColor,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.add_rounded,
                          size: 20,
                          color: context.foregroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(widget.cartItem.quantity.toString()),
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(side: BorderSide(color: context.borderColor)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        cartController.remove(widget.cartItem);
                        setState(() {});
                        widget.onUpdated();

                      },
                      highlightColor: context.borderColor,
                      splashColor: context.borderColor,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.remove_rounded,
                          size: 20,
                          color: context.foregroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
