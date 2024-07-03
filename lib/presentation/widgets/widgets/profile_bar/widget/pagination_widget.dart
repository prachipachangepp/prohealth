import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';

class PaginationControlsWidget extends StatelessWidget {
  final int currentPage;
  final List<dynamic> items;
  final int itemsPerPage;
  final void Function() onPreviousPagePressed;
  final void Function(int) onPageNumberPressed;
  final void Function() onNextPagePressed;

  const PaginationControlsWidget({
    required this.currentPage,
    required this.items,
    required this.itemsPerPage,
    required this.onPreviousPagePressed,
    required this.onPageNumberPressed,
    required this.onNextPagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: ColorManager.fmediumgrey.withOpacity(0.2),
                width: 0.79,
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.only(bottom: 1.5),
              icon: Icon(Icons.chevron_left),
              onPressed: onPreviousPagePressed,
              color: Colors.black,
              iconSize: 20,
            ),
          ),
          SizedBox(width: 3),
          for (var i = 1; i <= (items.length / itemsPerPage).ceil(); i++)
            if (i == 1 ||
                i == currentPage ||
                i == (items.length / itemsPerPage).ceil())
              InkWell(
                onTap: () => onPageNumberPressed(i),
                child: Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: currentPage == i ? Colors.blue : ColorManager.fmediumgrey.withOpacity(0.2),
                      width: currentPage == i ? 2.0 : 1.0,
                    ),
                    color: currentPage == i ? Colors.blue : Colors.transparent,
                  ),
                  child: Text(
                    '$i',
                    style: TextStyle(
                      color: currentPage == i ? Colors.white : ColorManager.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            else if (i == currentPage - 1 || i == currentPage + 1)
              Text(
                '..',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: ColorManager.fmediumgrey.withOpacity(0.2),
                width: 0.79,
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.only(bottom: 1.5),
              icon: Icon(Icons.chevron_right),
              onPressed: onNextPagePressed,
              color: Colors.black,
              iconSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
