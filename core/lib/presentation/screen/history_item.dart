import 'package:core/models/result_history.dart';
import 'package:flutter/material.dart';

import '../../style/colors.dart';

class HistoryItem extends StatelessWidget {
  ResultHistory resultHistory;

  HistoryItem({super.key, required this.resultHistory});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: fourthBlue.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    'Skor: ${resultHistory.score}',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(child: Text(
                  'Klasifikasi: ${resultHistory.classification}',
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                resultHistory.date,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
