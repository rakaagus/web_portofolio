import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/bloc/experience/widget/job_entity.dart';
import 'package:web_portofolio/presentation/widget/hovered_card_widget.dart';

class OrganizationTimelineRow extends StatelessWidget {
  final OrganizationExperience organization;
  final ColorScheme colorScheme;
  final bool isLast;
  final bool isMobile;

  const OrganizationTimelineRow({
    required this.organization,
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
                    color: colorScheme.primary.withOpacity(0.3),
                    border: Border.all(color: colorScheme.primary, width: 2.5),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary,
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
    final org = organization;

    final Widget logoWidget = Container(
      padding: EdgeInsets.all(isMobile ? 8 : 10),
      decoration: BoxDecoration(
        color: colorScheme.tertiary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        org.logo is IconData ? org.logo : Icons.groups_rounded,
        color: colorScheme.tertiary,
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
                          org.orgName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        org.period,
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
                    org.position,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
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
                    org.orgName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    org.position,
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              org.period,
              style: TextStyle(fontSize: 13, color: colorScheme.onSurface.withOpacity(0.4)),
            ),
          ],
        ),

        const SizedBox(height: 20),
        Text(
          org.description,
          style: TextStyle(
            fontSize: isMobile ? 13 : 14,
            height: 1.5,
            color: colorScheme.onSurface.withOpacity(0.75),
          ),
        ),
        const SizedBox(height: 16),
        ...org.achievements.map((achv) => Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Icon(Icons.star_rounded, size: 14, color: colorScheme.tertiary.withOpacity(0.7)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  achv,
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
      ],
    );
  }
}