import 'package:flutter/material.dart';
import '../constants.dart';

class HealthCastTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final Widget? trailing; 

  const HealthCastTopBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing, 
  });

  @override
  Size get preferredSize => const Size.fromHeight(96);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final scale = _scaleForWidth(w);
        final padX = (w * 0.05).clamp(16.0, 22.0);

        return Material(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [PRIMARY, DARK_PRIMARY],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  padX,
                  (12 * scale).clamp(10.0, 14.0),
                  padX,
                  (14 * scale).clamp(12.0, 18.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: TEXT_COLOR_WHITE,
                              fontSize: (16 * scale).clamp(15.0, 18.0),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: TEXT_COLOR_WHITE.withOpacity(0.78),
                              fontSize: (12.5 * scale).clamp(12.0, 14.0),
                              fontWeight: FontWeight.w400,
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // trailing ??
                    //     Container(
                    //       width: (36 * scale).clamp(34.0, 40.0),
                    //       height: (36 * scale).clamp(34.0, 40.0),
                    //       decoration: BoxDecoration(
                    //         color: TEXT_COLOR_WHITE.withOpacity(0.14),
                    //         shape: BoxShape.circle,
                    //         border: Border.all(
                    //           color: TEXT_COLOR_WHITE.withOpacity(0.18),
                    //           width: 1,
                    //         ),
                    //       ),
                    //       child: Icon(
                    //         Icons.person_outline_rounded,
                    //         color: TEXT_COLOR_WHITE.withOpacity(0.9),
                    //         size: (18 * scale).clamp(16.0, 20.0),
                    //       ),
                    //     ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

double _scaleForWidth(double width) {
  if (width >= 900) return 1.12;
  if (width >= 700) return 1.08;
  if (width >= 500) return 1.04;
  return 1.0;
}
