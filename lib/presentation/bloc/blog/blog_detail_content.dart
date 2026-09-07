import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_portofolio/domain/model/ui/blog_ui_model.dart';
import 'package:web_portofolio/presentation/Navigation/app_routes.dart';
import 'package:web_portofolio/presentation/widget/global_footer.dart';
import 'package:web_portofolio/presentation/widget/gradient_background.dart';
import 'package:web_portofolio/presentation/widget/hovered_card_widget.dart';
import 'package:web_portofolio/presentation/widget/scroll_reveal_widget.dart';
import 'package:web_portofolio/presentation/widget/tech_chip.dart';

class BlogDetailContent extends StatelessWidget {
  final String slug;
  final ScrollController scrollController;
  final Function(String url) onNavigate;

  const BlogDetailContent({
    super.key,
    required this.slug,
    required this.scrollController,
    required this.onNavigate,
  });

  Future<void> _launchExternalUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final allBlogs = BlogUiModel.dummyBlogs;
    final currentIndex = allBlogs.indexWhere((b) => b.slug == slug);
    final blog = currentIndex != -1 ? allBlogs[currentIndex] : allBlogs.first;

    final BlogUiModel? prevBlog = currentIndex > 0 ? allBlogs[currentIndex - 1] : null;
    final BlogUiModel? nextBlog = currentIndex < allBlogs.length - 1 ? allBlogs[currentIndex + 1] : null;

    return Stack(
      children: [
        const Positioned.fill(
          child: MeshGradientBackground(style: 3),
        ),
        ListView(
          controller: scrollController,
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: isMobile ? 90 : 120),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 860),
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScrollRevealWidget(
                      delay: Duration.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Breadcrumbs
                          Row(
                            children: [
                              InkWell(
                                onTap: () => onNavigate('/blogs'),
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.arrow_back_rounded, size: 16, color: colorScheme.primary),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Blogs",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text("  /  ", style: TextStyle(color: colorScheme.onSurface.withOpacity(0.4))),
                              Flexible(
                                child: Text(
                                  blog.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colorScheme.onSurface.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Category & Read Time Meta
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  blog.category.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "${blog.date}  •  ${blog.readTime}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Blog Title
                          Text(
                            blog.title,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: isMobile ? 28 : 42,
                              fontWeight: FontWeight.bold,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Tags
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: blog.tags.map((tag) => TechChip(label: tag)).toList(),
                          ),
                          const SizedBox(height: 32),

                          // Medium Redirection Banner / Button (If from Medium)
                          if (blog.mediumUrl != null && blog.mediumUrl!.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(bottom: 36),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isDark ? Colors.white12 : Colors.black12,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(FontAwesomeIcons.medium, size: 24),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Also published on Medium",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                        ),
                                        Text(
                                          "Read, applaud, or comment on Medium directly.",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: colorScheme.onSurface.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  ElevatedButton.icon(
                                    onPressed: () => _launchExternalUrl(blog.mediumUrl!),
                                    icon: const Icon(Icons.open_in_new_rounded, size: 14),
                                    label: const Text("Read on Medium"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isDark ? Colors.white : Colors.black87,
                                      foregroundColor: isDark ? Colors.black : Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Article Content Card
                    ScrollRevealWidget(
                      delay: const Duration(milliseconds: 100),
                      child: HoverSolidCard(
                        padding: EdgeInsets.all(isMobile ? 24 : 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildArticleParagraphs(context, blog.content, colorScheme),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Next / Previous Blog Navigation
                    ScrollRevealWidget(
                      delay: const Duration(milliseconds: 150),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Continue Reading",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              if (prevBlog != null)
                                Expanded(
                                  child: _buildNavigationCard(
                                    context: context,
                                    isNext: false,
                                    blog: prevBlog,
                                    onTap: () => onNavigate(AppRoutes.blogDetailPath(prevBlog.slug)),
                                  ),
                                )
                              else
                                const Spacer(),
                              const SizedBox(width: 16),
                              if (nextBlog != null)
                                Expanded(
                                  child: _buildNavigationCard(
                                    context: context,
                                    isNext: true,
                                    blog: nextBlog,
                                    onTap: () => onNavigate(AppRoutes.blogDetailPath(nextBlog.slug)),
                                  ),
                                )
                              else
                                const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            GlobalFooter(onNavigate: onNavigate),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildArticleParagraphs(BuildContext context, String rawContent, ColorScheme colorScheme) {
    final lines = rawContent.trim().split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        widgets.add(const SizedBox(height: 16));
      } else if (trimmed.startsWith('### ')) {
        widgets.add(const SizedBox(height: 24));
        widgets.add(
          Text(
            trimmed.substring(4),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        );
        widgets.add(const SizedBox(height: 12));
      } else if (trimmed.startsWith('- ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• ", style: TextStyle(fontSize: 16, color: colorScheme.primary)),
                Expanded(
                  child: Text(
                    trimmed.substring(2),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        widgets.add(
          Text(
            trimmed,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.75,
              fontSize: 15,
              color: colorScheme.onSurface.withOpacity(0.85),
            ),
          ),
        );
      }
    }

    return widgets;
  }

  Widget _buildNavigationCard({
    required BuildContext context,
    required bool isNext,
    required BlogUiModel blog,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return HoverSolidCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: isNext ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: isNext ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (!isNext) Icon(Icons.arrow_back_rounded, size: 14, color: colorScheme.primary),
                  if (!isNext) const SizedBox(width: 6),
                  Text(
                    isNext ? "NEXT ARTICLE" : "PREVIOUS ARTICLE",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: colorScheme.primary,
                    ),
                  ),
                  if (isNext) const SizedBox(width: 6),
                  if (isNext) Icon(Icons.arrow_forward_rounded, size: 14, color: colorScheme.primary),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                blog.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: isNext ? TextAlign.end : TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
