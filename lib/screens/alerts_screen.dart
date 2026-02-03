import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final List<_AlertItem> _alerts = [
    _AlertItem(
      id: "a1",
      type: _AlertType.urgent,
      title: "High Dengue Risk Alert",
      message:
          "Increased risk in your area due to recent\nrainfall. Take preventive measures.",
      timeAgo: "2 hours ago",
      isRead: false,
      icon: Icons.warning_amber_rounded,
    ),
    _AlertItem(
      id: "a2",
      type: _AlertType.advisory,
      title: "Health Advisory",
      message:
          "Free dengue screening available at Quezon\nCity Health Office this weekend.",
      timeAgo: "1 day ago",
      isRead: false,
      icon: Icons.notifications_none_rounded,
    ),
    _AlertItem(
      id: "a3",
      type: _AlertType.info,
      title: "Weather Update",
      message: "Light rains expected tonight.\nStay alert and monitor advisories.",
      timeAgo: "2 days ago",
      isRead: true,
      icon: Icons.cloud_outlined,
    ),
     _AlertItem(
      id: "a4",
      type: _AlertType.urgent,
      title: "Fogging Schedule Alert",
      message:
          "Vector control operations in Makati CBD area scheduled for tomorrow 5-8 AM.",
      timeAgo: "2 hours ago",
      isRead: false,
      icon: Icons.warning_amber_rounded,
    ),
    _AlertItem(
      id: "a5",
      type: _AlertType.advisory,
      title: "Community Health Program",
      message:
          "Free consultation and mosquito net distribution",
      timeAgo: "1 day ago",
      isRead: false,
      icon: Icons.notifications_none_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
          ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRead(String id) {
    setState(() {
      final idx = _alerts.indexWhere((e) => e.id == id);
      if (idx == -1) return;
      _alerts[idx] = _alerts[idx].copyWith(isRead: !_alerts[idx].isRead);
    });
  }

  void _delete(String id) {
    setState(() {
      _alerts.removeWhere((e) => e.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
  gradient:  LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.0, 0.6, 1.0],
  colors: [
    Color(0xFFDDECF4),
    Color(0xFFFFFFFF),
    Color(0xFFC7DDEA),

  ],
),

),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const HealthCastTopBar(
          title: "Alerts",
          subtitle: "Health alerts and information",
        ),
        body: LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            final scale = _scaleForWidth(w);
            final padX = (w * 0.05).clamp(16.0, 22.0);

            final bottomInset = MediaQuery.of(context).padding.bottom;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                padX,
                (14 * scale).clamp(12.0, 18.0),
                padX,
                (20 * scale) + kBottomNavigationBarHeight + bottomInset + 12,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    children: List.generate(_alerts.length, (i) {
                      final item = _alerts[i];

                      
                      final start = (i * 0.10).clamp(0.0, 0.7);
                      final end = (start + 0.35).clamp(0.3, 1.0);

                      final anim = CurvedAnimation(
                        parent: _controller,
                        curve: Interval(start, end, curve: Curves.easeOutCubic),
                      );

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: (14 * scale).clamp(12.0, 18.0),
                        ),
                        child: FadeTransition(
                          opacity: anim,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.08),
                              end: Offset.zero,
                            ).animate(anim),
                            child: _SwipeableAlertCard(
                              scale: scale,
                              item: item,
                              onToggleRead: () => _toggleRead(item.id),
                              onDelete: () => _delete(item.id),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: const HealthCastBottomNav(currentIndex: 2),
      ),
    );
  }
}

class _SwipeableAlertCard extends StatelessWidget {
  final double scale;
  final _AlertItem item;
  final VoidCallback onToggleRead;
  final VoidCallback onDelete;

  const _SwipeableAlertCard({
    required this.scale,
    required this.item,
    required this.onToggleRead,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.horizontal,

      
      background: _SwipeBackground(
        icon: item.isRead ? Icons.mark_email_unread_outlined : Icons.mark_email_read_outlined,
        text: item.isRead ? "Mark Unread" : "Mark Read",
        alignLeft: true,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SECONDARY.withOpacity(0.75),
            DARK_PRIMARY.withOpacity(0.90),
          ],
        ),
      ),

      secondaryBackground: const _SwipeBackground(
        icon: Icons.delete_outline_rounded,
        text: "Delete",
        alignLeft: false,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE7000B), Color(0xFFFDA4AF)],
        ),
      ),

      confirmDismiss: (dir) async {
        if (dir == DismissDirection.startToEnd) {
          
          onToggleRead();
          return false;
        } else if (dir == DismissDirection.endToStart) {
          
          return true;
        }
        return false;
      },

      onDismissed: (_) => onDelete(),

      child: _AlertCard(
        scale: s,
        item: item,
        onTap: onToggleRead, 
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final double scale;
  final _AlertItem item;
  final VoidCallback onTap;

  const _AlertCard({
    required this.scale,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    final iconGradient = item.type.iconGradient;
    final pillGradient = item.type.pillGradient;
    final pillText = item.type.pillText;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        opacity: item.isRead ? 0.70 : 1.0,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(14 * s, 14 * s, 14 * s, 14 * s),
          decoration: BoxDecoration(
            color: TEXT_COLOR_WHITE,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Container(
                width: (36 * s).clamp(34.0, 40.0),
                height: (36 * s).clamp(34.0, 40.0),
                decoration: BoxDecoration(
                  gradient: iconGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  item.icon,
                  color: TEXT_COLOR_WHITE,
                  size: (18 * s).clamp(16.0, 20.0),
                ),
              ),

              SizedBox(width: (12 * s).clamp(10.0, 14.0)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              color: PRIMARY.withOpacity(0.95),
                              fontSize: (13.5 * s).clamp(13.0, 15.5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: pillGradient,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            pillText,
                            style: TextStyle(
                              color: TEXT_COLOR_WHITE,
                              fontSize: (10.5 * s).clamp(10.0, 11.5),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        if (!item.isRead) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: SECONDARY,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),

                    SizedBox(height: (8 * s).clamp(6.0, 10.0)),

                    Text(
                      item.message,
                      style: TextStyle(
                        color: DARK_PRIMARY.withOpacity(0.78),
                        fontSize: (11.8 * s).clamp(11.0, 13.0),
                        fontWeight: FontWeight.w400,
                        height: 1.25,
                      ),
                    ),

                    SizedBox(height: (10 * s).clamp(8.0, 12.0)),

                    Text(
                      item.timeAgo,
                      style: TextStyle(
                        color: DARK_PRIMARY.withOpacity(0.45),
                        fontSize: (10.5 * s).clamp(10.0, 11.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SwipeBackground extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool alignLeft;
  final Gradient gradient;

  const _SwipeBackground({
    required this.icon,
    required this.text,
    required this.alignLeft,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: alignLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!alignLeft) ...[
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 10),
            Icon(icon, color: Colors.white),
          ] else ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ],
      ),
    );
  }
}



enum _AlertType { urgent, advisory, info }

extension on _AlertType {
  String get pillText {
    switch (this) {
      case _AlertType.urgent:
        return "URGENT";
      case _AlertType.advisory:
        return "ADVISORY";
      case _AlertType.info:
        return "INFO";
    }
  }

  Gradient get pillGradient {
    switch (this) {
      case _AlertType.urgent:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE7000B), Color(0xFFFDA4AF)],
        );
      case _AlertType.advisory:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF009966), Color(0xFF00FFAA)],
        );
      case _AlertType.info:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1F6CFF), Color(0xFF66B6FF)],
        );
    }
  }

  Gradient get iconGradient {
    
    return pillGradient;
  }
}

class _AlertItem {
  final String id;
  final _AlertType type;
  final String title;
  final String message;
  final String timeAgo;
  final bool isRead;
  final IconData icon;

  const _AlertItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.isRead,
    required this.icon,
  });

  _AlertItem copyWith({
    bool? isRead,
  }) {
    return _AlertItem(
      id: id,
      type: type,
      title: title,
      message: message,
      timeAgo: timeAgo,
      isRead: isRead ?? this.isRead,
      icon: icon,
    );
  }
}

double _scaleForWidth(double width) {
  if (width >= 900) return 1.12;
  if (width >= 700) return 1.08;
  if (width >= 500) return 1.04;
  return 1.0;
}
