import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav.dart';

class DiseasesScreen extends StatefulWidget {
  const DiseasesScreen({super.key});

  @override
  State<DiseasesScreen> createState() => _DiseasesScreenState();
}

class _DiseasesScreenState extends State<DiseasesScreen> {
  static const _diseases = <String>[
    "Dengue Fever",
    "Chikungunya",
    "Zika Virus",
    "Malaria",
    "Japanese Encephalitis",
  ];

  String _selected = _diseases.first;

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
            Color(0xFFCFE2EE),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        appBar: const HealthCastTopBar(
          title: "Disease Information",
          subtitle: "Learn about mosquito-borne diseases and how to protect yourself",
        ),
        body: LayoutBuilder(
          builder: (context, c) {
            final w = c.maxWidth;
            final scale = _scaleForWidth(w);
            final padX = (w * 0.05).clamp(16.0, 22.0);
            final bottomInset = MediaQuery.of(context).padding.bottom;

            final info = DiseaseInfo.data[_selected]!;

            
            final hotspots = info.activeHotspots;

            final items = <AccordionItem>[
              AccordionItem(
                title: "What are the warning signs?",
                icon: Icons.warning_amber_rounded,
                bodyText: info.warningSigns,
              ),
              AccordionItem(
                title: "What should I do if I have ${_shortName(_selected)}?",
                icon: Icons.favorite_border_rounded,
                richBody: info.careGuidelines,
              ),
              AccordionItem(
                title: "Do’s and Don’ts",
                icon: Icons.checklist_rounded,
                richBody: info.dosAndDontsRich,
              ),

              
              AccordionItem(
                title: "Active Hotspots",
                icon: Icons.location_on_outlined,
                hotspots: hotspots,
              ),

              AccordionItem(
                title: "Weather Correlation",
                icon: Icons.insights_outlined,
                bodyText:
                    "Mosquito activity often increases with suitable temperature and standing water after rainfall. When you connect historical weather + case data, HealthCast can show correlations and risk signals for early action.",
              ),
            ];

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                padX,
                14 * scale,
                padX,
                20 * scale + kBottomNavigationBarHeight + bottomInset + 14,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DiseaseChips(
                        scale: scale,
                        items: _diseases,
                        selected: _selected,
                        onSelected: (v) => setState(() => _selected = v),
                      ),
                      SizedBox(height: (12 * scale).clamp(10.0, 16.0)),
                      _DiseaseMainCard(
                        scale: scale,
                        disease: _selected,
                        info: info,
                      ),
                      SizedBox(height: (12 * scale).clamp(10.0, 16.0)),
                      _InfoAccordion(scale: scale, items: items),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: const HealthCastBottomNav(currentIndex: 3),
      ),
    );
  }
}



class _DiseaseChips extends StatelessWidget {
  final double scale;
  final List<String> items;
  final String selected;
  final ValueChanged<String> onSelected;

  const _DiseaseChips({
    required this.scale,
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  @override
  @override
Widget build(BuildContext context) {
  final s = scale;

  
  LinearGradient _riskGradient(Color base) {
    final mid = Color.lerp(base, Colors.white, 0.18)!;
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [base, mid, base],
    );
  }

  
  return Wrap(
    spacing: (8 * s).clamp(6.0, 10.0),
    runSpacing: (8 * s).clamp(6.0, 10.0),
    children: items.map((d) {
      final isActive = d == selected;

      
      final di = DiseaseInfo.data[d]!;
      final chipBg = di.riskBg;
      final chipFg = di.riskFg;

      return InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () => onSelected(d),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),

          
          padding: EdgeInsets.symmetric(
            horizontal: (12 * s).clamp(10.0, 14.0),
            vertical: (8 * s).clamp(7.0, 10.0),
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),

            
            gradient: isActive ? _riskGradient(chipFg) : null,

            
            color: isActive ? null : TEXT_COLOR_WHITE,

            border: Border.all(
             
              color: isActive ? Colors.transparent : chipFg.withOpacity(0.35),
              width: 1,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isActive ? 0.12 : 0.05),
                blurRadius: isActive ? 14 : 10,
                offset: const Offset(0, 7),
              ),
            ],
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                d,
                style: TextStyle(
                  
                  color: isActive ? TEXT_COLOR_WHITE : chipFg,
                  fontSize: (12.0 * s).clamp(11.2, 13.2),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.15,
                ),
              ),

             
              if (isActive) ...[
                SizedBox(width: (8 * s).clamp(6.0, 10.0)),
                Container(
                  width: (26 * s).clamp(22.0, 28.0),
                  height: (26 * s).clamp(22.0, 28.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 8,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check_rounded,
                    size: (16 * s).clamp(14.0, 18.0),
                    color: const Color(0xFF9FB4C2),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }).toList(),
  );
}

}

class _DiseaseMainCard extends StatelessWidget {
  final double scale;
  final String disease;
  final DiseaseInfo info;

  const _DiseaseMainCard({
    required this.scale,
    required this.disease,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14 * s, 14 * s, 14 * s, 12 * s),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.5, 0.7, 1.0],
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFF3F8FB),
            Color.fromARGB(255, 197, 224, 238),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _DiseaseIcon(scale: s, bg: info.iconBg, icon: info.icon),
              SizedBox(width: (12 * s).clamp(10.0, 14.0)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      disease,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: PRIMARY,
                        fontSize: (15.0 * s).clamp(14.0, 17.0),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: (6 * s).clamp(5.0, 8.0)),
                    Row(
                      children: [
                        _TinyPill(
                          text: info.riskLabel,
                          fg: info.riskFg,
                          bg: info.riskBg,
                          scale: s,
                        ),
                        SizedBox(width: (8 * s).clamp(6.0, 10.0)),
                        _TinyPill(
                          text: info.trendLabel,
                          fg: info.trendFg,
                          bg: info.trendBg,
                          scale: s,
                          icon: Icons.trending_up_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: (12 * s).clamp(10.0, 14.0)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all((10 * s).clamp(9.0, 12.0)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF9FCFE),
                  Color(0xFFF1F7FB),
                ],
              ),
              border: Border.all(
                color: LIGHT_PRIMARY.withOpacity(0.28),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _MiniStatTile(
                    scale: s,
                    icon: Icons.groups_2_outlined,
                    label: "Active Cases",
                    value: info.activeCasesText,
                  ),
                ),
                SizedBox(width: (10 * s).clamp(8.0, 12.0)),
                Expanded(
                  child: _MiniStatTile(
                    scale: s,
                    icon: Icons.location_on_outlined,
                    label: "Hotspots",
                    value: info.hotspotsText,
                  ),
                ),
                SizedBox(width: (10 * s).clamp(8.0, 12.0)),
                Expanded(
                  child: _MiniStatTile(
                    scale: s,
                    icon: Icons.warning_amber_rounded,
                    label: "Warning Signs",
                    value: info.warningCountText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: (12 * s).clamp(10.0, 14.0)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(12 * s, 10 * s, 12 * s, 10 * s),
            decoration: BoxDecoration(
              color: const Color(0xFFF6FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: LIGHT_PRIMARY.withOpacity(0.35),
                width: 1,
              ),
            ),
            child: Text(
              info.shortSummary,
              style: TextStyle(
                color: DARK_PRIMARY.withOpacity(0.78),
                fontSize: (11.8 * s).clamp(11.3, 13.0),
                fontWeight: FontWeight.w500,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiseaseIcon extends StatelessWidget {
  final double scale;
  final Color bg;
  final IconData icon;

  const _DiseaseIcon({
    required this.scale,
    required this.bg,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = (44 * scale).clamp(40.0, 52.0);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        icon,
        color: TEXT_COLOR_WHITE,
        size: (22 * scale).clamp(20.0, 26.0),
      ),
    );
  }
}

class _TinyPill extends StatelessWidget {
  final String text;
  final Color fg;
  final Color bg;
  final double scale;
  final IconData? icon;

  const _TinyPill({
    required this.text,
    required this.fg,
    required this.bg,
    required this.scale,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (10 * s).clamp(8.0, 12.0),
        vertical: (6 * s).clamp(5.0, 8.0),
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: (14 * s).clamp(12.0, 16.0), color: fg),
            SizedBox(width: (6 * s).clamp(4.0, 8.0)),
          ],
          Text(
            text,
            style: TextStyle(
              color: fg,
              fontSize: (11.0 * s).clamp(10.5, 12.5),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _HotspotPill extends StatelessWidget {
  final double scale;
  final String text;

  const _HotspotPill({
    required this.scale,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (10 * s).clamp(8.0, 12.0),
        vertical: (6 * s).clamp(5.0, 8.0),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF6FAFC),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: LIGHT_PRIMARY.withOpacity(0.35),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: PRIMARY.withOpacity(0.80),
          fontSize: (11.2 * s).clamp(10.7, 12.6),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _MiniStatTile extends StatelessWidget {
  final double scale;
  final IconData icon;
  final String label;
  final String value;

  const _MiniStatTile({
    required this.scale,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Container(
      padding: EdgeInsets.fromLTRB(10 * s, 10 * s, 10 * s, 10 * s),
      decoration: BoxDecoration(
        color: const Color(0xFFF6FAFC).withOpacity(0.65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: LIGHT_PRIMARY.withOpacity(0.30),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: SECONDARY.withOpacity(0.9), size: (18 * s).clamp(16.0, 20.0)),
          SizedBox(height: (6 * s).clamp(5.0, 8.0)),
          Text(
            value,
            style: TextStyle(
              color: PRIMARY,
              fontSize: (13.0 * s).clamp(12.5, 15.0),
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PRIMARY.withOpacity(0.55),
              fontSize: (10.5 * s).clamp(10.0, 12.0),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}



class RichBody {
  final String headerTitle;
  final String headerSubtitle;
  final List<String> steps;

  const RichBody({
    required this.headerTitle,
    required this.headerSubtitle,
    required this.steps,
  });
}

class AccordionItem {
  final String title;
  final IconData icon;
  final String? bodyText;
  final RichBody? richBody;

  
  final List<String>? hotspots;

  const AccordionItem({
    required this.title,
    required this.icon,
    this.bodyText,
    this.richBody,
    this.hotspots,
  });
}

class _InfoAccordion extends StatelessWidget {
  final double scale;
  final List<AccordionItem> items;

  const _InfoAccordion({
    required this.scale,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Column(
      children: items.map((it) {
        return Padding(
          padding: EdgeInsets.only(bottom: (10 * s).clamp(8.0, 12.0)),
          child: _AccordionTile(scale: s, item: it),
        );
      }).toList(),
    );
  }
}

class _AccordionTile extends StatelessWidget {
  final double scale;
  final AccordionItem item;

  const _AccordionTile({
    required this.scale,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    final hasHotspots = item.hotspots != null && item.hotspots!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: TEXT_COLOR_WHITE,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
            horizontal: (14 * s).clamp(12.0, 18.0),
            vertical: (8 * s).clamp(7.0, 10.0),
          ),
          childrenPadding: EdgeInsets.fromLTRB(
            (14 * s).clamp(12.0, 18.0),
            0,
            (14 * s).clamp(12.0, 18.0),
            (12 * s).clamp(10.0, 16.0),
          ),
          leading: Container(
            width: (34 * s).clamp(32.0, 40.0),
            height: (34 * s).clamp(32.0, 40.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF6FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: LIGHT_PRIMARY.withOpacity(0.35),
                width: 1,
              ),
            ),
            child: Icon(item.icon, color: SECONDARY, size: (18 * s).clamp(16.0, 20.0)),
          ),
          title: Text(
            item.title,
            style: TextStyle(
              color: DARK_PRIMARY,
              fontSize: (12.8 * s).clamp(12.0, 14.0),
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: PRIMARY.withOpacity(0.55),
          ),
          children: [
            
            if (hasHotspots)
              Wrap(
                spacing: (8 * s).clamp(6.0, 10.0),
                runSpacing: (8 * s).clamp(6.0, 10.0),
                children: item.hotspots!
                    .map((place) => _HotspotPill(scale: s, text: place))
                    .toList(),
              ),

            if (!hasHotspots && item.richBody != null)
              _RichAccordionBody(scale: s, body: item.richBody!),

            if (!hasHotspots && item.richBody == null && item.bodyText != null)
              Text(
                item.bodyText!,
                style: TextStyle(
                  color: PRIMARY.withOpacity(0.72),
                  fontSize: (11.6 * s).clamp(11.0, 13.0),
                  fontWeight: FontWeight.w600,
                  height: 1.28,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RichAccordionBody extends StatelessWidget {
  final double scale;
  final RichBody body;

  const _RichAccordionBody({
    required this.scale,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
          decoration: BoxDecoration(
            color: const Color(0xFFF6FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: LIGHT_PRIMARY.withOpacity(0.35),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                body.headerTitle,
                style: TextStyle(
                  color: PRIMARY,
                  fontSize: (12.5 * s).clamp(12.0, 14.0),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: (6 * s).clamp(5.0, 8.0)),
              Text(
                body.headerSubtitle,
                style: TextStyle(
                  color: PRIMARY.withOpacity(0.70),
                  fontSize: (11.5 * s).clamp(11.0, 13.0),
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: (12 * s).clamp(10.0, 16.0)),
        Column(
          children: List.generate(body.steps.length, (i) {
            return Padding(
              padding: EdgeInsets.only(bottom: (10 * s).clamp(8.0, 12.0)),
              child: _StepTile(
                scale: s,
                number: i + 1,
                text: body.steps[i],
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _StepTile extends StatelessWidget {
  final double scale;
  final int number;
  final String text;

  const _StepTile({
    required this.scale,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final s = scale;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12 * s, 12 * s, 12 * s, 12 * s),
      decoration: BoxDecoration(
        color: TEXT_COLOR_WHITE,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
        border: Border.all(
          color: LIGHT_PRIMARY.withOpacity(0.35),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: (30 * s).clamp(28.0, 34.0),
            height: (30 * s).clamp(28.0, 34.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  SECONDARY.withOpacity(0.95),
                  DARK_PRIMARY.withOpacity(0.95),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: DARK_PRIMARY.withOpacity(0.18),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              "$number",
              style: TextStyle(
                color: TEXT_COLOR_WHITE,
                fontSize: (12 * s).clamp(11.0, 13.0),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(width: (12 * s).clamp(10.0, 14.0)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: PRIMARY.withOpacity(0.86),
                fontSize: (12.0 * s).clamp(11.5, 13.5),
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class DiseaseInfo {
  final IconData icon;
  final Color iconBg;

  final String riskLabel;
  final Color riskFg;
  final Color riskBg;

  final String trendLabel;
  final Color trendFg;
  final Color trendBg;

  final String activeCasesText;
  final String hotspotsText;
  final String warningCountText;

 
  final List<String> activeHotspots;

  final String shortSummary;
  final String overview;
  final String commonSymptoms;
  final String warningSigns;

  final RichBody careGuidelines;
  final RichBody dosAndDontsRich;

  const DiseaseInfo({
    required this.icon,
    required this.iconBg,
    required this.riskLabel,
    required this.riskFg,
    required this.riskBg,
    required this.trendLabel,
    required this.trendFg,
    required this.trendBg,
    required this.activeCasesText,
    required this.hotspotsText,
    required this.warningCountText,
    required this.activeHotspots,
    required this.shortSummary,
    required this.overview,
    required this.commonSymptoms,
    required this.warningSigns,
    required this.careGuidelines,
    required this.dosAndDontsRich,
  });

  static const data = <String, DiseaseInfo>{
    "Dengue Fever": DiseaseInfo(
      icon: Icons.bug_report_outlined,
      iconBg: Color(0xFFE7000B),
      riskLabel: "High Risk",
      riskFg: Color(0xFFE7000B),
      riskBg: Color(0xFFFFE7EA),
      trendLabel: "Rising",
      trendFg: Color(0xFFE7000B),
      trendBg: Color(0xFFFFE7EA),
      activeCasesText: "1,117",
      hotspotsText: "4",
      warningCountText: "8",

      
      activeHotspots: [
        "Quezon City",
        "Manila",
        "Pasig City",
        "Marikina City",
      ],

      shortSummary:
          "A mosquito-borne viral infection causing flu-like illness, and occasionally developing into a potentially lethal complication.",
      overview:
          "Dengue is caused by dengue viruses transmitted mainly by Aedes mosquitoes. Infection can range from mild to severe. A second dengue infection can increase the risk of severe dengue.",
      commonSymptoms:
          "Fever, severe headache, pain behind the eyes, muscle/joint pain, nausea/vomiting, rash, and fatigue.",
      warningSigns:
          "Seek urgent care if warning signs appear (often as fever goes down): severe abdominal pain, persistent vomiting, bleeding gums/nose, blood in vomit/stool, extreme fatigue/restlessness, difficulty breathing.",
      careGuidelines: RichBody(
        headerTitle: "Essential Care Guidelines",
        headerSubtitle:
            "Follow these steps to manage dengue symptoms and prevent complications.",
        steps: [
          "Seek medical attention immediately if warning signs appear",
          "Drink plenty of fluids (oral rehydration solution, water, soup)",
          "Rest and avoid strenuous activity",
          "Monitor temperature and symptoms regularly",
          "Avoid aspirin and NSAIDs (e.g., ibuprofen) due to bleeding risk",
          "Use paracetamol/acetaminophen for fever (as advised by a healthcare professional)",
        ],
      ),
      dosAndDontsRich: RichBody(
        headerTitle: "Do’s and Don’ts",
        headerSubtitle: "Safer habits help recovery and reduce spread.",
        steps: [
          "Do use mosquito protection (repellent, long sleeves, nets) to avoid further bites",
          "Do remove standing water around your home to reduce mosquito breeding",
          "Do follow up with a health facility if symptoms persist or worsen",
          "Don’t self-medicate with blood-thinning pain relievers (aspirin/ibuprofen)",
          "Don’t ignore warning signs—early treatment reduces severe dengue risk",
        ],
      ),
    ),

    "Chikungunya": DiseaseInfo(
      icon: Icons.health_and_safety_rounded,
      iconBg: Color(0xFFE17100),
      riskLabel: "Moderate Risk",
      riskFg: Color(0xFFE17100),
      riskBg: Color(0xFFFFF0E4),
      trendLabel: "Monitor",
      trendFg: Color(0xFFE17100),
      trendBg: Color(0xFFFFF0E4),
      activeCasesText: "—",
      hotspotsText: "—",
      warningCountText: "—",
      activeHotspots: const [],
      shortSummary:
          "Chikungunya is a mosquito-borne viral illness that often causes fever and severe joint pain. Joint pain may last weeks to months in some people.",
      overview:
          "Chikungunya is transmitted by Aedes mosquitoes. Most people recover fully, but joint pain can be prolonged, especially in older adults.",
      commonSymptoms:
          "Fever, intense joint pain, joint swelling, muscle pain, headache, fatigue, and rash.",
      warningSigns:
          "Seek medical care for severe dehydration, confusion, breathing difficulty, persistent vomiting, or worsening symptoms—especially in infants, older adults, or people with chronic illness.",
      careGuidelines: RichBody(
        headerTitle: "Essential Care Guidelines",
        headerSubtitle: "Supportive care helps relieve fever and joint pain.",
        steps: [
          "Rest and limit activity to reduce joint stress",
          "Drink plenty of fluids to prevent dehydration",
          "Use fever or pain relief only as advised by a healthcare professional",
          "Apply warm compresses or gentle stretching for joint discomfort",
          "Avoid mosquito bites during the first week to reduce spread",
          "Seek medical advice if joint pain is severe or lasts for weeks",
        ],
      ),
      dosAndDontsRich: RichBody(
        headerTitle: "Do’s and Don’ts",
        headerSubtitle: "Reduce symptoms and prevent mosquito transmission.",
        steps: [
          "Do use repellents and mosquito nets to prevent bites",
          "Do get enough rest and pace your movement",
          "Do consult a health professional if symptoms persist",
          "Don’t overexert painful joints—this can worsen inflammation",
          "Don’t assume it’s mild if you have high-risk conditions—get checked",
        ],
      ),
    ),

   "Zika Virus": DiseaseInfo(
  icon: Icons.coronavirus_rounded,

  
  iconBg: const Color(0xFF2E7D32),

 
  riskLabel: "Low Risk",
      riskFg: Color(0xFF009966),
      riskBg: Color(0xFFE6FFF5),

  
  trendLabel: "Stable",
      trendFg: Color(0xFF009966),
      trendBg: Color(0xFFE6FFF5),

  activeCasesText: "—",
  hotspotsText: "—",
  warningCountText: "—",
  activeHotspots: const [],

  shortSummary:
      "Zika is often mild, but infection during pregnancy can cause serious birth defects and neurological complications.",
  overview:
      "Zika virus is mainly spread by Aedes mosquitoes and can also be transmitted through sexual contact. Many infections show no symptoms.",
  commonSymptoms:
      "Mild fever, rash, red eyes (conjunctivitis), joint pain, muscle pain, and headache.",
  warningSigns:
      "Pregnant individuals with exposure or symptoms should seek medical guidance promptly. Urgent care is needed for neurological symptoms such as weakness or severe headache.",
  careGuidelines: RichBody(
    headerTitle: "Essential Care Guidelines",
    headerSubtitle: "Most cases are mild, but pregnancy-related care is crucial.",
    steps: [
      "Consult a healthcare professional if pregnant or planning pregnancy after exposure",
      "Rest and drink plenty of fluids",
      "Use fever or pain relief only as advised by a healthcare professional",
      "Prevent mosquito bites to reduce spread",
      "Follow guidance to prevent sexual transmission after exposure",
      "Seek urgent care if neurological symptoms occur",
    ],
  ),
  dosAndDontsRich: RichBody(
    headerTitle: "Do’s and Don’ts",
    headerSubtitle: "Protect pregnancy and prevent spread.",
    steps: [
      "Do use repellents and long sleeves during mosquito-active hours",
      "Do consult prenatal care providers if exposed during pregnancy",
      "Do practice safer sex as advised after exposure",
      "Don’t ignore pregnancy-related risk—even mild symptoms matter",
      "Don’t rely on symptoms alone—many Zika infections are asymptomatic",
    ],
  ),
),


    "Malaria": DiseaseInfo(
      icon: Icons.bloodtype_outlined,
      iconBg: Color(0xFF009966),
      riskLabel: "Varies by Area",
      riskFg: Color(0xFF009966),
      riskBg: Color(0xFFE6FFF5),
      trendLabel: "Check Travel",
      trendFg: Color(0xFF009966),
      trendBg: Color(0xFFE6FFF5),
      activeCasesText: "—",
      hotspotsText: "—",
      warningCountText: "—",
      activeHotspots: const [],
      shortSummary:
          "Malaria is caused by parasites transmitted by Anopheles mosquitoes and can become severe quickly without treatment.",
      overview:
          "Malaria is caused by Plasmodium parasites. Early diagnosis and treatment are vital to prevent severe disease, especially for P. falciparum infections.",
      commonSymptoms:
          "Fever, chills, sweating, headache, body aches, nausea, vomiting, and fatigue. Symptoms may appear days to weeks after exposure.",
      warningSigns:
          "Severe malaria may cause confusion, seizures, breathing difficulty, jaundice, persistent vomiting, or loss of consciousness—seek emergency care immediately.",
      careGuidelines: RichBody(
        headerTitle: "Essential Care Guidelines",
        headerSubtitle: "Prompt testing and treatment prevent severe malaria.",
        steps: [
          "Seek medical care promptly for fever after travel to risk areas",
          "Get tested using rapid tests or blood smears as advised",
          "Start prescribed treatment immediately if diagnosed",
          "Stay hydrated and rest during recovery",
          "Return to care if fever persists or symptoms worsen",
          "Use mosquito prevention to avoid further bites",
        ],
      ),
      dosAndDontsRich: RichBody(
        headerTitle: "Do’s and Don’ts",
        headerSubtitle: "Prevent bites and avoid delayed treatment.",
        steps: [
          "Do use mosquito nets and repellents, especially at night",
          "Do complete the full course of prescribed medicines",
          "Do seek immediate care for danger signs",
          "Don’t delay testing—malaria can worsen rapidly",
          "Don’t stop treatment early even if you feel better",
        ],
      ),
    ),

    "Japanese Encephalitis": DiseaseInfo(
  icon: Icons.psychology_alt_outlined,

  
  iconBg: const Color(0xFF2E7D32),

  
  riskLabel: "Low Risk",
        riskFg: Color(0xFF009966),
      riskBg: Color(0xFFE6FFF5),

  trendLabel: "Stable",
       trendFg: Color(0xFF009966),
      trendBg: Color(0xFFE6FFF5),

  activeCasesText: "—",
  hotspotsText: "—",
  warningCountText: "—",
  activeHotspots: const [],

  shortSummary:
      "Japanese encephalitis is a mosquito-borne viral infection that can cause brain inflammation and may be life-threatening.",
  overview:
      "JE virus is transmitted mainly by Culex mosquitoes, often near rice fields and pig farms. Most infections are asymptomatic, but severe disease can cause encephalitis.",
  commonSymptoms:
      "Most infections show no symptoms. Severe illness includes fever, headache, neck stiffness, confusion, seizures, and neurological deficits.",
  warningSigns:
      "Urgent signs include seizures, confusion, weakness or paralysis, stiff neck, or altered consciousness—seek emergency care immediately.",
  careGuidelines: RichBody(
    headerTitle: "Essential Care Guidelines",
    headerSubtitle: "Severe symptoms require emergency evaluation.",
    steps: [
      "Seek emergency care immediately for neurological symptoms",
      "Avoid mosquito bites using repellents and nets",
      "Follow medical advice—treatment is supportive in hospital settings",
      "Monitor for worsening consciousness or breathing problems",
      "Discuss vaccination guidance if living in or traveling to risk areas",
      "Reduce mosquito breeding by removing standing water",
    ],
  ),
  dosAndDontsRich: RichBody(
    headerTitle: "Do’s and Don’ts",
    headerSubtitle: "Prevention is key; don’t delay urgent care.",
    steps: [
      "Do seek urgent care for seizures or confusion",
      "Do use mosquito protection, especially in rural areas",
      "Do follow vaccination recommendations when applicable",
      "Don’t ignore neurological symptoms—JE can progress fast",
      "Don’t rely on home care alone for severe symptoms",
    ],
  ),
),

  };
}



double _scaleForWidth(double width) {
  if (width >= 900) return 1.12;
  if (width >= 700) return 1.08;
  if (width >= 500) return 1.04;
  return 1.0;
}

String _shortName(String s) {
  if (s == "Dengue Fever") return "dengue";
  if (s == "Chikungunya") return "chikungunya";
  if (s == "Zika Virus") return "Zika";
  if (s == "Malaria") return "malaria";
  if (s == "Japanese Encephalitis") return "Japanese encephalitis";
  return s;
}
