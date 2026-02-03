import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class SurveillanceScreen extends StatefulWidget {
  const SurveillanceScreen({super.key});

  @override
  State<SurveillanceScreen> createState() => _SurveillanceScreenState();
}

class _SurveillanceScreenState extends State<SurveillanceScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _diseases = const [
    "Dengue",
    "Zika",
    "Chikungunya",
    "Malaria",
    "Japanese Encephalitis",
  ];

  String _selectedDisease = "Dengue";

  final List<String> _regions = const [
    "All Regions",
    "NCR (National Capital Region)",
    "CAR (Cordillera Administrative Region)",
    "Region I (Ilocos Region)",
    "Region II (Cagayan Valley)",
    "Region III (Central Luzon)",
    "Region IV-A (CALABARZON)",
    "Region IV-B (MIMAROPA)",
    "Region V (Bicol Region)",
    "Region VI (Western Visayas)",
    "Region VII (Central Visayas)",
    "Region VIII (Eastern Visayas)",
    "Region IX (Zamboanga Peninsula)",
    "Region X (Northern Mindanao)",
    "Region XI (Davao Region)",
    "Region XII (SOCCSKSARGEN)",
    "Region XIII (Caraga)",
    "BARMM (Bangsamoro Autonomous Region in Muslim Mindanao)",
  ];

  String _selectedRegion = "All Regions";

  static const Map<String, List<String>> _areasByRegion = {
    "NCR (National Capital Region)": [
      "Caloocan",
      "Las Piñas",
      "Makati",
      "Malabon",
      "Mandaluyong",
      "Manila",
      "Marikina",
      "Muntinlupa",
      "Navotas",
      "Parañaque",
      "Pasay",
      "Pasig",
      "Pateros",
      "Quezon City",
      "San Juan",
      "Taguig",
      "Valenzuela",
    ],
    "CAR (Cordillera Administrative Region)": [
      "Abra",
      "Apayao",
      "Benguet",
      "Ifugao",
      "Kalinga",
      "Mountain Province",
    ],
    "Region I (Ilocos Region)": [
      "Ilocos Norte",
      "Ilocos Sur",
      "La Union",
      "Pangasinan",
    ],
    "Region II (Cagayan Valley)": [
      "Batanes",
      "Cagayan",
      "Isabela",
      "Nueva Vizcaya",
      "Quirino",
    ],
    "Region III (Central Luzon)": [
      "Aurora",
      "Bataan",
      "Bulacan",
      "Nueva Ecija",
      "Pampanga",
      "Tarlac",
      "Zambales",
    ],
    "Region IV-A (CALABARZON)": [
      "Batangas",
      "Cavite",
      "Laguna",
      "Quezon",
      "Rizal",
    ],
    "Region IV-B (MIMAROPA)": [
      "Marinduque",
      "Occidental Mindoro",
      "Oriental Mindoro",
      "Palawan",
      "Romblon",
    ],
    "Region V (Bicol Region)": [
      "Albay",
      "Camarines Norte",
      "Camarines Sur",
      "Catanduanes",
      "Masbate",
      "Sorsogon",
    ],
    "Region VI (Western Visayas)": [
      "Aklan",
      "Antique",
      "Capiz",
      "Guimaras",
      "Iloilo",
      "Negros Occidental",
    ],
    "Region VII (Central Visayas)": [
      "Bohol",
      "Cebu",
      "Negros Oriental",
      "Siquijor",
    ],
    "Region VIII (Eastern Visayas)": [
      "Biliran",
      "Eastern Samar",
      "Leyte",
      "Northern Samar",
      "Samar",
      "Southern Leyte",
    ],
    "Region IX (Zamboanga Peninsula)": [
      "Zamboanga del Norte",
      "Zamboanga del Sur",
      "Zamboanga Sibugay",
    ],
    "Region X (Northern Mindanao)": [
      "Bukidnon",
      "Camiguin",
      "Lanao del Norte",
      "Misamis Occidental",
      "Misamis Oriental",
    ],
    "Region XI (Davao Region)": [
      "Davao de Oro",
      "Davao del Norte",
      "Davao del Sur",
      "Davao Occidental",
      "Davao Oriental",
    ],
    "Region XII (SOCCSKSARGEN)": [
      "Cotabato",
      "Sarangani",
      "South Cotabato",
      "Sultan Kudarat",
    ],
    "Region XIII (Caraga)": [
      "Agusan del Norte",
      "Agusan del Sur",
      "Dinagat Islands",
      "Surigao del Norte",
      "Surigao del Sur",
    ],
    "BARMM (Bangsamoro Autonomous Region in Muslim Mindanao)": [
      "Basilan",
      "Lanao del Sur",
      "Maguindanao del Norte",
      "Maguindanao del Sur",
      "Sulu",
      "Tawi-Tawi",
    ],
  };

  late final AnimationController _pageCtrl;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    _pageCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _fadeIn = CurvedAnimation(parent: _pageCtrl, curve: Curves.easeOutCubic);
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _pageCtrl, curve: Curves.easeOutCubic));

    _pageCtrl.forward();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  String get _switchKey => "${_selectedDisease}__${_selectedRegion}";

  void _setDisease(String v) {
    if (v == _selectedDisease) return;
    setState(() => _selectedDisease = v);
  }

  void _setRegion(String v) {
    if (v == _selectedRegion) return;
    setState(() => _selectedRegion = v);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
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
          title: "Surveillance Update",
          subtitle: "Disease surveillance data for the Philippines",
        ),
        body: LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            final scale = _scaleForWidth(w);
            final padX = (w * 0.05).clamp(16.0, 22.0);

            final visibleAreas = _getVisibleAreas();
            final stats = _getStats();

            final bottomInset = MediaQuery.of(context).padding.bottom;
            final navSpace = (72 * scale).clamp(68.0, 84.0);

            return FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideIn,
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    padX,
                    14 * scale,
                    padX,
                    (20 * scale) +
                        navSpace +
                        kBottomNavigationBarHeight +
                        bottomInset,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Label(text: "Select Disease", scale: scale),
                          SizedBox(height: (6 * scale).clamp(6.0, 10.0)),
                          _PickerCard(
                            scale: scale,
                            title: "Disease",
                            value: _selectedDisease,
                            items: _diseases,
                            leadingIcon: Icons.bug_report_outlined,
                            sheetTitle: "Select a Disease",
                            onChanged: _setDisease,
                            searchable: true,
                          ),
                          SizedBox(height: (10 * scale).clamp(8.0, 14.0)),
                          _Label(text: "Filter by Region", scale: scale),
                          SizedBox(height: (6 * scale).clamp(6.0, 10.0)),
                          _PickerCard(
                            scale: scale,
                            title: "Region",
                            value: _selectedRegion,
                            items: _regions,
                            leadingIcon: Icons.public_outlined,
                            sheetTitle: "Select a Region",
                            onChanged: _setRegion,
                            searchable: true,
                          ),
                          SizedBox(height: (14 * scale).clamp(12.0, 18.0)),

                          // ✅ Animated stats row (card-by-card stagger)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 260),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            transitionBuilder: (child, anim) {
                              final slide = Tween<Offset>(
                                begin: const Offset(0, 0.06),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: anim,
                                  curve: Curves.easeOutCubic,
                                ),
                              );
                              return FadeTransition(
                                opacity: anim,
                                child: SlideTransition(position: slide, child: child),
                              );
                            },
                            child: _AnimatedStatsRow(
                              key: ValueKey("stats_$_switchKey"),
                              scale: scale,
                              stats: stats,
                            ),
                          ),

                          SizedBox(height: (14 * scale).clamp(12.0, 18.0)),

                          // Animated table card when selections change
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 280),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            transitionBuilder: (child, anim) {
                              final slide = Tween<Offset>(
                                begin: const Offset(0, 0.05),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: anim,
                                  curve: Curves.easeOutCubic,
                                ),
                              );
                              return FadeTransition(
                                opacity: anim,
                                child: SlideTransition(position: slide, child: child),
                              );
                            },
                            child: _CardShell(
                              key: ValueKey("table_$_switchKey"),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _CardTitle(
                                    icon: Icons.place_outlined,
                                    title: "Regions & Provinces",
                                    scale: scale,
                                  ),
                                  SizedBox(height: (10 * scale).clamp(8.0, 12.0)),
                                  if (_selectedRegion == "All Regions") ...[
                                    _AllRegionTables(scale: scale),
                                  ] else ...[
                                    // ✅ row animation runs here
                                    _AreaTable(
                                      scale: scale,
                                      regionLabel: _selectedRegion,
                                      areas: visibleAreas,
                                      animate: true,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: const HealthCastBottomNav(currentIndex: 1),
      ),
    );
  }

  List<String> _getVisibleAreas() {
    if (_selectedRegion == "All Regions") {
      return const ["Quezon City", "Cebu", "Davao del Sur", "Iloilo", "Cagayan"];
    }
    return _areasByRegion[_selectedRegion] ?? const [];
  }

  Map<String, dynamic> _getStats() {
    // Demo stats (deterministic by selection)
    final seed = (_selectedDisease.hashCode + _selectedRegion.hashCode).abs();
    final active = 900 + (seed % 500);
    final died = 30 + (seed % 80);
    final total = active + died + (seed % 120);

    return {
      "active": active,
      "died": died,
      "total": total,
    };
  }
}

class _Label extends StatelessWidget {
  final String text;
  final double scale;
  const _Label({required this.text, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: DARK_PRIMARY.withOpacity(0.70),
        fontSize: (11.5 * scale).clamp(11.0, 13.0),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

/// ✅ Animated stats row (staggered)
class _AnimatedStatsRow extends StatelessWidget {
  final double scale;
  final Map<String, dynamic> stats;

  const _AnimatedStatsRow({
    super.key,
    required this.scale,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Row(
      children: [
        Expanded(
          child: _StaggerIn(
            index: 0,
            child: _StatCard(
              scale: s,
              title: "Active",
              value: stats["active"]!.toString(),
              icon: Icons.show_chart_rounded,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1F6CFF), Color(0xFF66B6FF)],
              ),
            ),
          ),
        ),
        SizedBox(width: (10 * s).clamp(8.0, 12.0)),
        Expanded(
          child: _StaggerIn(
            index: 1,
            child: _StatCard(
              scale: s,
              title: "Deceased",
              value: stats["died"]!.toString(),
              icon: Icons.error_outline,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE7000B), Color(0xFFFDA4AF)],
              ),
            ),
          ),
        ),
        SizedBox(width: (10 * s).clamp(8.0, 12.0)),
        Expanded(
          child: _StaggerIn(
            index: 2,
            child: _StatCard(
              scale: s,
              title: "Total",
              value: stats["total"]!.toString(),
              icon: Icons.bar_chart_rounded,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [SECONDARY.withOpacity(0.70), DARK_PRIMARY],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StaggerIn extends StatefulWidget {
  final int index;
  final Widget child;

  const _StaggerIn({
    required this.index,
    required this.child,
  });

  @override
  State<_StaggerIn> createState() => _StaggerInState();
}

class _StaggerInState extends State<_StaggerIn> {
  bool _go = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 70 * widget.index), () {
      if (!mounted) return;
      setState(() => _go = true);
    });
  }

  @override
  void didUpdateWidget(covariant _StaggerIn oldWidget) {
    super.didUpdateWidget(oldWidget);

    
    if (oldWidget.child.key != widget.child.key) {
      _go = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Future.delayed(Duration(milliseconds: 70 * widget.index), () {
          if (!mounted) return;
          setState(() => _go = true);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      opacity: _go ? 1 : 0,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        offset: _go ? Offset.zero : const Offset(0, 0.08),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
          scale: _go ? 1 : 0.96,
          child: widget.child,
        ),
      ),
    );
  }
}


class _PickerCard extends StatelessWidget {
  final double scale;
  final String title;
  final String value;
  final List<String> items;
  final String sheetTitle;
  final IconData leadingIcon;
  final ValueChanged<String> onChanged;
  final bool searchable;

  const _PickerCard({
    required this.scale,
    required this.title,
    required this.value,
    required this.items,
    required this.sheetTitle,
    required this.leadingIcon,
    required this.onChanged,
    this.searchable = true,
  });

  Future<void> _openSheet(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _PickerSheet(
          scale: scale,
          title: sheetTitle,
          current: value,
          items: items,
          searchable: searchable,
        );
      },
    );

    if (selected != null && selected != value) onChanged(selected);
  }

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => _openSheet(context),
      child: Ink(
        decoration: BoxDecoration(
          color: TEXT_COLOR_WHITE,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: LIGHT_PRIMARY.withOpacity(0.35), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(12 * s, 11 * s, 10 * s, 11 * s),
          child: Row(
            children: [
              Container(
                width: (34 * s).clamp(32.0, 38.0),
                height: (34 * s).clamp(32.0, 38.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      SECONDARY.withOpacity(0.18),
                      DARK_PRIMARY.withOpacity(0.10),
                    ],
                  ),
                  border: Border.all(
                    color: DARK_PRIMARY.withOpacity(0.08),
                    width: 1,
                  ),
                ),
                child: Icon(
                  leadingIcon,
                  color: DARK_PRIMARY.withOpacity(0.75),
                  size: (18 * s).clamp(16.0, 20.0),
                ),
              ),
              SizedBox(width: (10 * s).clamp(8.0, 12.0)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: DARK_PRIMARY.withOpacity(0.55),
                        fontSize: (10.5 * s).clamp(10.0, 12.0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: (2 * s).clamp(2.0, 4.0)),
                    Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: PRIMARY.withOpacity(0.95),
                        fontSize: (13.2 * s).clamp(12.5, 14.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: (8 * s).clamp(6.0, 10.0)),
              Icon(
                Icons.expand_more_rounded,
                color: DARK_PRIMARY.withOpacity(0.65),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerSheet extends StatefulWidget {
  final double scale;
  final String title;
  final String current;
  final List<String> items;
  final bool searchable;

  const _PickerSheet({
    required this.scale,
    required this.title,
    required this.current,
    required this.items,
    required this.searchable,
  });

  @override
  State<_PickerSheet> createState() => _PickerSheetState();
}

class _PickerSheetState extends State<_PickerSheet> {
  final _searchCtrl = TextEditingController();
  String _q = "";

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.scale;

    final maxH = MediaQuery.of(context).size.height * 0.82;
    final filtered = widget.searchable && _q.trim().isNotEmpty
        ? widget.items
            .where((e) => e.toLowerCase().contains(_q.trim().toLowerCase()))
            .toList()
        : widget.items;

    return SafeArea(
      top: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxH),
          child: Container(
            decoration: BoxDecoration(
              color: TEXT_COLOR_WHITE,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  blurRadius: 22,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 8),
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14 * s, 6 * s, 14 * s, 10 * s),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: PRIMARY,
                            fontSize: (14.0 * s).clamp(13.0, 16.0),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close_rounded,
                          color: DARK_PRIMARY.withOpacity(0.70),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.searchable)
                  Padding(
                    padding: EdgeInsets.fromLTRB(14 * s, 0, 14 * s, 10 * s),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12 * s),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: DARK_PRIMARY.withOpacity(0.08),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: DARK_PRIMARY.withOpacity(0.55),
                          ),
                          SizedBox(width: (8 * s).clamp(6.0, 10.0)),
                          Expanded(
                            child: TextField(
                              controller: _searchCtrl,
                              onChanged: (v) => setState(() => _q = v),
                              style: TextStyle(
                                color: PRIMARY.withOpacity(0.92),
                                fontSize: (12.6 * s).clamp(12.0, 14.0),
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: "Search…",
                                hintStyle: TextStyle(
                                  color: DARK_PRIMARY.withOpacity(0.40),
                                  fontWeight: FontWeight.w500,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          if (_q.isNotEmpty)
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                _searchCtrl.clear();
                                setState(() => _q = "");
                              },
                              icon: Icon(
                                Icons.close_rounded,
                                size: (18 * s).clamp(16.0, 20.0),
                                color: DARK_PRIMARY.withOpacity(0.55),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              "No results",
                              style: TextStyle(
                                color: DARK_PRIMARY.withOpacity(0.55),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding:
                              EdgeInsets.fromLTRB(10 * s, 4 * s, 10 * s, 14 * s),
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 1,
                            color: Colors.black.withOpacity(0.06),
                          ),
                          itemBuilder: (context, i) {
                            final item = filtered[i];
                            final selected = item == widget.current;

                            return InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => Navigator.pop(context, item),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                curve: Curves.easeOut,
                                padding: EdgeInsets.fromLTRB(
                                    10 * s, 11 * s, 10 * s, 11 * s),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: selected
                                      ? SECONDARY.withOpacity(0.10)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: selected
                                        ? SECONDARY.withOpacity(0.35)
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: (34 * s).clamp(32.0, 38.0),
                                      height: (34 * s).clamp(32.0, 38.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: selected
                                            ? SECONDARY.withOpacity(0.22)
                                            : DARK_PRIMARY.withOpacity(0.06),
                                      ),
                                      child: Icon(
                                        selected
                                            ? Icons.check_rounded
                                            : Icons.circle_outlined,
                                        color: selected
                                            ? SECONDARY.withOpacity(0.95)
                                            : DARK_PRIMARY.withOpacity(0.45),
                                        size: (18 * s).clamp(16.0, 20.0),
                                      ),
                                    ),
                                    SizedBox(width: (10 * s).clamp(8.0, 12.0)),
                                    Expanded(
                                      child: Text(
                                        item,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: selected
                                              ? PRIMARY.withOpacity(0.96)
                                              : PRIMARY.withOpacity(0.88),
                                          fontSize:
                                              (12.8 * s).clamp(12.0, 14.5),
                                          fontWeight: selected
                                              ? FontWeight.w700
                                              : FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final double scale;
  final String title;
  final String value;
  final IconData icon;
  final Gradient gradient;

  const _StatCard({
    required this.scale,
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return LayoutBuilder(
      builder: (context, c) {
        final tight = c.maxHeight < 70;

        final padV = tight
            ? (8 * s).clamp(6.0, 10.0)
            : (12 * s).clamp(10.0, 14.0);
        final padH = (12 * s).clamp(10.0, 14.0);

        final iconSize =
            tight ? (16 * s).clamp(14.0, 18.0) : (18 * s).clamp(16.0, 20.0);
        final valueSize = tight
            ? (14.5 * s).clamp(13.0, 16.0)
            : (16.5 * s).clamp(15.5, 18.5);
        final titleSize = tight
            ? (10.5 * s).clamp(10.0, 11.5)
            : (11.5 * s).clamp(11.0, 12.5);

        return Container(
          padding: EdgeInsets.fromLTRB(padH, padV, padH, padV),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  color: TEXT_COLOR_WHITE.withOpacity(0.95), size: iconSize),
              SizedBox(height: tight ? 6 : 10),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: TextStyle(
                    color: TEXT_COLOR_WHITE,
                    fontSize: valueSize,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: TEXT_COLOR_WHITE.withOpacity(0.85),
                    fontSize: titleSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CardShell extends StatelessWidget {
  final Widget child;
  const _CardShell({required this.child, required ValueKey<String> key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: TEXT_COLOR_WHITE,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: child,
    );
  }
}

class _CardTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final double scale;

  const _CardTitle({
    required this.icon,
    required this.title,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Row(
      children: [
        Icon(icon,
            color: SECONDARY.withOpacity(0.95),
            size: (18 * s).clamp(16.0, 20.0)),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: PRIMARY,
            fontSize: (13.5 * s).clamp(13.0, 15.5),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _GradientHeaderBar extends StatelessWidget {
  final double scale;
  final String text;

  const _GradientHeaderBar({
    required this.scale,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12 * s, 10 * s, 12 * s, 10 * s),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SECONDARY.withOpacity(0.85),
            DARK_PRIMARY.withOpacity(0.95),
          ],
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: TEXT_COLOR_WHITE,
          fontSize: (12.0 * s).clamp(11.0, 13.0),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final double scale;
  final String leftTitle;

  const _TableHeader({required this.scale, required this.leftTitle});

  @override
  Widget build(BuildContext context) {
    final s = scale;

    final headerStyle = TextStyle(
      color: DARK_PRIMARY.withOpacity(0.75),
      fontSize: (11.0 * s).clamp(10.0, 12.0),
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(12 * s, 10 * s, 12 * s, 8 * s),
      child: Row(
        children: [
          Expanded(flex: 5, child: Text(leftTitle, style: headerStyle)),
          Expanded(flex: 2, child: Center(child: Text("Active", style: headerStyle))),
          Expanded(
              flex: 2, child: Center(child: Text("Deceased", style: headerStyle))),
          Expanded(flex: 2, child: Center(child: Text("Total", style: headerStyle))),
        ],
      ),
    );
  }
}


class _AreaTable extends StatefulWidget {
  final double scale;
  final String regionLabel;
  final List<String> areas;

  
  final bool animate;

  const _AreaTable({
    required this.scale,
    required this.regionLabel,
    required this.areas,
    this.animate = true,
  });

  @override
  State<_AreaTable> createState() => _AreaTableState();
}

class _AreaTableState extends State<_AreaTable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    if (widget.animate) {
      _ctrl.forward(from: 0);
    } else {
      _ctrl.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant _AreaTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.regionLabel != widget.regionLabel ||
        oldWidget.areas.length != widget.areas.length ||
        oldWidget.animate != widget.animate) {
      if (widget.animate) {
        _ctrl.forward(from: 0);
      } else {
        _ctrl.value = 1;
      }
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.scale;
    final screenH = MediaQuery.of(context).size.height;

    final maxBodyH = (screenH * 0.35).clamp(220.0, 460.0);
    final needsScroll = widget.areas.length > 8;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: const Color(0xFFF6FAFC),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _GradientHeaderBar(scale: s, text: widget.regionLabel),
            _TableHeader(scale: s, leftTitle: "Province / City"),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxBodyH),
              child: Scrollbar(
                thumbVisibility: needsScroll,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: needsScroll
                      ? const ClampingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  itemCount: widget.areas.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  itemBuilder: (context, i) {
                    final name = widget.areas[i];

                    final base = name.hashCode.abs() % 30;
                    final active = 10 + base;
                    final died = base % 4;
                    final total = active + died;

                    final n = widget.areas.length.clamp(1, 30);
                    final start = (i / (n + 6)).clamp(0.0, 1.0);
                    final end = (start + 0.45).clamp(0.0, 1.0);

                    final anim = CurvedAnimation(
                      parent: _ctrl,
                      curve: Interval(start, end, curve: Curves.easeOutCubic),
                    );

                    return FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.08),
                          end: Offset.zero,
                        ).animate(anim),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: (12 * s).clamp(10.0, 14.0),
                            vertical: (10 * s).clamp(8.0, 12.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: PRIMARY.withOpacity(0.90),
                                    fontSize: (11.5 * s).clamp(10.5, 12.5),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "$active",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF1F6CFF),
                                    fontSize: (11.5 * s).clamp(10.5, 12.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "$died",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFFE7000B),
                                    fontSize: (11.5 * s).clamp(10.5, 12.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "$total",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: PRIMARY.withOpacity(0.90),
                                    fontSize: (11.5 * s).clamp(10.5, 12.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllRegionTables extends StatelessWidget {
  final double scale;
  const _AllRegionTables({required this.scale});

  @override
  Widget build(BuildContext context) {
    final s = scale;

    final regionKeys = const [
      "NCR (National Capital Region)",
      "CAR (Cordillera Administrative Region)",
      "Region I (Ilocos Region)",
      "Region II (Cagayan Valley)",
      "Region III (Central Luzon)",
      "Region IV-A (CALABARZON)",
      "Region IV-B (MIMAROPA)",
      "Region V (Bicol Region)",
      "Region VI (Western Visayas)",
      "Region VII (Central Visayas)",
      "Region VIII (Eastern Visayas)",
      "Region IX (Zamboanga Peninsula)",
      "Region X (Northern Mindanao)",
      "Region XI (Davao Region)",
      "Region XII (SOCCSKSARGEN)",
      "Region XIII (Caraga)",
      "BARMM (Bangsamoro Autonomous Region in Muslim Mindanao)",
    ];

    return Column(
      children: [
        for (int i = 0; i < regionKeys.length; i++) ...[
          _AreaTable(
            scale: s,
            regionLabel: regionKeys[i],
            areas: _SurveillanceScreenState._areasByRegion[regionKeys[i]] ?? const [],
            animate: false, 
          ),
          SizedBox(height: (12 * s).clamp(10.0, 16.0)),
        ],
      ],
    );
  }
}

double _scaleForWidth(double width) {
  if (width >= 900) return 1.12;
  if (width >= 700) return 1.08;
  if (width >= 500) return 1.04;
  return 1.0;
}
