import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/bloc/experience/widget/job_entity.dart';
import 'package:web_portofolio/presentation/widget/hovered_card_widget.dart';

class ExperienceTimelineRow extends StatelessWidget {
  final CompanyExperience experience;
  final ColorScheme colorScheme;
  final bool isLast;
  final bool isMobile;

  const ExperienceTimelineRow({
    required this.experience,
    required this.colorScheme,
    required this.isLast,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final double dotTopMargin = isMobile ? 36 : 46;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: isMobile ? 20 : 32,
            child: Column(
              children: [
                Container(
                  width: 2,
                  height: dotTopMargin - 7,
                  color: colorScheme.onSurface.withOpacity(0.15),
                ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: colorScheme.onSurface, width: 2.5),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: colorScheme.onSurface.withOpacity(0.15),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: isMobile ? 12 : 20),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: HoverSolidCard(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                child: _buildCardContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    final exp = experience;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Widget logoWidget = Container(
      padding: EdgeInsets.all(isMobile ? 8 : 10),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        exp.logo is IconData ? exp.logo : Icons.business_rounded,
        color: isDark ? colorScheme.tertiary : colorScheme.primary,
        size: isMobile ? 24 : 26,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isMobile
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            logoWidget,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          exp.companyName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isDark ? colorScheme.tertiary : colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        exp.totalPeriod,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface.withOpacity(0.4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    exp.location,
                    style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ],
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logoWidget,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp.companyName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isDark ? colorScheme.tertiary : colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    exp.location,
                    style: TextStyle(fontSize: 13, color: colorScheme.onSurface.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
            Text(
              exp.totalPeriod,
              style: TextStyle(fontSize: 13, color: colorScheme.onSurface.withOpacity(0.4)),
            ),
          ],
        ),

        ...exp.jobs.asMap().entries.map((entry) {
          int jobIndex = entry.key;
          JobRole job = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (jobIndex > 0) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(
                    color: isDark ? Colors.white10 : Colors.black.withOpacity(0.06),
                    thickness: 1.2,
                  ),
                ),
              ] else ...[
                const SizedBox(height: 24),
              ],

              isMobile
                  ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          job.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        _buildTypeBadge(job.type),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    job.period,
                    style: TextStyle(fontSize: 11, color: colorScheme.onSurface.withOpacity(0.4)),
                  ),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    job.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildTypeBadge(job.type),
                  const Spacer(),
                  Text(
                    job.period,
                    style: TextStyle(fontSize: 13, color: colorScheme.onSurface.withOpacity(0.4)),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ...job.responsibilities.map((resp) => Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Icon(Icons.circle, size: 5, color: colorScheme.onSurface.withOpacity(0.5)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        resp,
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 14,
                          height: 1.5,
                          color: colorScheme.onSurface.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.skills.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withOpacity(0.04) : const Color(0xFFF1F3F5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark ? Colors.white10 : Colors.black.withOpacity(0.03),
                      ),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildTypeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}