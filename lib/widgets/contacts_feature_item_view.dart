import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class ContactsFeatureItemView extends StatelessWidget {
  final IconData icon;
  final String label;

  ContactsFeatureItemView({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.black38,
              size: MARGIN_XLARGE,
            ),
            const SizedBox(height: MARGIN_MEDIUM_2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}