import 'package:flutter/material.dart';
import 'package:web_portofolio/domain/model/ui/blog_ui_model.dart';
import 'package:web_portofolio/presentation/Navigation/app_routes.dart';
import 'package:web_portofolio/presentation/widget/empty_data_widget.dart';
import 'package:web_portofolio/presentation/widget/global_footer.dart';
import 'package:web_portofolio/presentation/widget/gradient_background.dart';
import 'package:web_portofolio/presentation/widget/hovered_card_widget.dart';
import 'package:web_portofolio/presentation/widget/scroll_reveal_widget.dart';
import 'package:web_portofolio/presentation/widget/tech_chip.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlogContent extends StatefulWidget {
  final ScrollController scrollController;
  final Function(String url) onNavigate;

  const BlogContent({
    super.key,
    required this.scrollController,
    required this.onNavigate,
  });

  @override
  State<BlogContent> createState() => _BlogContentState();
}

class _BlogContentState extends State<BlogContent> {
  final List<BlogUiModel> blogs = BlogUiModel.dummyBlogs;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 650;
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        const Positioned.fill(
          child: MeshGradientBackground(style: 3),
        ),
        SingleChildScrollView(
          controller: widget.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: isMobile ? 80 : 120,
                    bottom: 60,
                    left: isMobile ? 24 : screenWidth * 0.1,
                    right: isMobile ? 24 : screenWidth * 0.1,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ScrollRevealWidget(
                            delay: Duration.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  l10n.postTitle,
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    fontSize: isMobile ? 32 : 40,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  l10n.postSubTitle,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface.withOpacity(0.7),
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 48),
                          if (blogs.isEmpty)
                            EmptyDataCardWidget(
                              title: l10n.emptyData(l10n.footerLinkBlogs),
                              description: l10n.emptyBlogSub,
                              isHaveButton: false,
                              iconTitle: "",
                              onPressButton: () {},
                            )
                          else
                            Column(
                              children: blogs.asMap().entries.map((entry) {
                                final index = entry.key;
                                final blog = entry.value;
                                return ScrollRevealWidget(
                                  delay: Duration(milliseconds: (index % 4) * 80),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: _buildBlogCard(context, colorScheme, blog),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                GlobalFooter(
                  onNavigate: (String url) {
                    widget.onNavigate(url);
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBlogCard(BuildContext context, ColorScheme colorScheme, BlogUiModel blog) {
    return HoverSolidCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          widget.onNavigate(AppRoutes.blogDetailPath(blog.slug));
        },
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${blog.category.toUpperCase()} • ${blog.date} • ${blog.readTime}",
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_outward_rounded,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                blog.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                  height: 1.3,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                blog.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  height: 1.6,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: blog.tags.map((tag) {
                  return TechChip(label: tag);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
