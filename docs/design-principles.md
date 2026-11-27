# Design principles for tomscott.name

This document describes the architectural, editorial and visual principles behind tomscott.name. It is intended to guide changes to the site rather than catalogue every declaration in the stylesheet. Together with the role and component guidance below, it serves as the design-system reference for the publication.

The site should feel like a small, considered publication. The writing is the main event. Design gives it structure, rhythm and identity without turning the site into a product interface or a stream of interchangeable content.

This guide records the settled design: the responsibilities of each part of the site, the rationale for its patterns and the conventions that should guide future changes. The canonical repository also contains a detailed homepage implementation guide at `.github/homepage.md`.

## Architectural principles

### Start with the grain of the web

Use links, URLs, headings, documents, feeds and other web primitives for their intended purposes. A link should identify the resource its label promises. An RSS link should lead to RSS; an article link should lead to the article.

Do not insert an intermediate page, interaction or proprietary abstraction merely to make a standard web resource feel more familiar. Helpful explanation can sit nearby, or in a page such as the Colophon, without changing the meaning of the link.

### Treat URLs and formats as public contracts

Published URLs may be bookmarked, cited, indexed or subscribed to. Preserve them unless there is a compelling reason to change them and a reliable redirect can be provided.

The representation is also part of the contract. HTML should remain useful to people, while RSS, XML, metadata and other machine-readable forms should remain valid for the software that consumes them.

### Enhance progressively

The baseline document should remain understandable and usable without client-side JavaScript. CSS should improve presentation without supplying meaning that is absent from the markup. JavaScript may add convenience, but should not be required for reading, navigation, discovery or subscription.

An enhancement must leave the underlying resource intact. If a browser cannot apply an optional presentation layer to the RSS feed, the feed should continue to behave as RSS.

### Make changes at the correct layer

Keep concerns in their natural homes:

- Posts and pages contain editorial material.
- Mustache templates provide document structure.
- CSS provides presentation.
- JavaScript provides optional behaviour.
- RSS provides syndication.
- Repository documentation explains implementation and maintenance.

A limitation in one layer is not, by itself, a reason to change the meaning of another. Prefer acknowledging a platform constraint to constructing a misleading workaround.

### Preserve one source of truth

The private `derivadow/tomscott.name` repository is the canonical source for the complete site. The local Blot/iCloud folder is the deployment working copy used to sync that source to Blot, and the public template repository is a derived publication of selected files from the private repository.

Do not maintain parallel editable versions of templates or assets. Make changes in the private repository, reconcile them into the existing Blot sync copy for deployment, and let the documented publication workflow derive the public template repository.

### Prefer the smallest coherent intervention

Solve the demonstrated problem with the fewest new concepts, dependencies and exceptions. Reuse an established pattern before adding a new component. Avoid adding pages, navigation choices or client-side behaviour whose continued existence would need explanation.

Small does not mean merely short. A small change preserves the surrounding architecture and reduces the number of new decisions the site must carry.

### Keep the site open and inspectable

Use semantic HTML, durable links and standard formats. Do not make ordinary reading or navigation dependent on a particular browser, account, service or script. Preserve useful metadata and accessible names.

The public templates should remain understandable without a build system. The published source is part of the site's commitment to an inspectable web.

### Verify the result, not merely the source

Check the rendered live page and the underlying representation. Shared changes should be reviewed on the homepage, an article, the archive, a tagged page, search, the error page and a narrow viewport as appropriate.

For feeds and other machine-readable resources, validate both the human presentation and the unmodified data consumed by clients. A successful deployment or automation run is not sufficient evidence on its own.

## Editorial principles

### Let writing remain writing

Essays should read as self-contained works with deliberate endings. Avoid generic recommendation modules or feed mechanics beneath them. Links that belong to the argument, sources and unobtrusive notes can strengthen a piece; generic prompts to consume more usually weaken its conclusion.

### Treat the homepage as a cover, not a feed

The homepage is a curated introduction to the writing. It is a composition in its own right, not an index or a stream of recent posts. It brings together fragments of essays, notes, quotations and personal writing from across the archive. The sequence follows associations between ideas rather than chronology; the reader is free to discover the connections.

The shared masthead describes the site as “Essays about culture, design, and technology”. A short introduction, “A few things I’ve been thinking about”, leads into a single column of passages. White space and changes in typographic scale provide rhythm. Titles and dates do not interrupt the reading: each passage is a link to the original article, with its title included in the accessible link name and its date preserved in a visually hidden time element.

A separate Latest list shows the five most recent published posts across all content types, with visible titles and visually hidden dates. The archive, tagged views, search and feed support more systematic discovery. The homepage and Colophon act as the publication's front and back covers, using a shared palette and page frame.

### Keep taxonomy in proportion

Article types and tags support organisation and browsing. They do not need to be repeated wherever an article appears. Use taxonomy on articles, archive, tagged and other discovery pages when it helps readers understand or find the writing. Keep the curated homepage sequence free of category labels.

### Earn every piece of interface

Do not add an element simply because it might be useful in isolation. Consider the accumulated effect on the site's character, the attention it takes from the writing and the maintenance burden it creates.

### Write in the site's voice

Use clear, direct British English. Avoid marketing language, generic calls to action and copy that sounds like a product onboarding flow. Interface text should be calm and specific.

## Visual principles

### Typography does most of the work

The design uses three type families with broadly distinct responsibilities:

- Inter is the reading face for body copy and supporting prose, including the narrative passages on the homepage.
- Tungsten is the display face for the masthead, article titles, and section headings.
- Nitti supplies most of the compact contextual furniture: navigation, page labels, tag treatments, captions, article and archive dates, and code.

These are roles rather than universal rules. Search-result dates inherit Inter; the error message uses display type.

Do not choose a face only for novelty or contrast. Each use should reinforce an established role. Optical harmony with surrounding text takes precedence over matching a nominal numerical size.

### Open essays and personal writing with an editorial lead-in

An essay or personal article opens with a Tungsten SemiBold (600) drop cap, approximately three lines deep. A marked editorial opening uses an uppercase initial in the interior accent ink, followed by an Inter semibold (600) all-small-caps phrase in ordinary reading ink, with 0.035em tracking. The rest of the paragraph returns to normal reading typography without a line break. Keep the original capitalisation and wording in the source.

Mark a natural opening phrase with Pandoc span syntax, for example `[The article was once a useful fiction]{.lead-in}.` The class is presentational, not semantic emphasis. Usually three to seven words are sufficient; a short complete sentence or a date phrase can also work. Preserve links and emphasis. Unmarked openings use the ordinary essay treatment; short self-contained opening quotations retain the reading face. Notes and papers do not use the editorial opening.

The initial uses native `initial-letter: 3.1` with a float fallback. Keep a consistent optical depth rather than introducing letter-specific or article-specific alignment rules. Opening punctuation belongs to the text and can hang beside the initial. Preserve legible source text where typographic features or optional enhancements are unsupported.

The first homepage passage uses the same editorial vocabulary at the cover's enlarged reading scale, with a yellow Tungsten initial and an optional small-cap opening phrase.

### Block quotations

Article block quotations keep the ordinary reading face, size, weight and colour. A rust-accent opening quotation mark sits in a modest left inset, with additional space above and below the block. The mark identifies quoted speech without turning it into a display pull quote or repeating the vertical-rule treatment used by archive connections and captions.

Apply this treatment to direct-child blockquotes in the article body. Preserve semantic `blockquote` markup, authored punctuation, internal emphasis and attribution. Use one decorative opening mark per block, including passages with several paragraphs; nested quotations retain their existing indentation. The CSS supplies an empty alternative for the decorative mark in supporting browsers. Reading and quotation semantics must remain intact without CSS or JavaScript.

### Colour and material

The two palettes distinguish the covers from the interior without changing the page frame. Use the named properties rather than duplicating hex values in component rules.

| Role / property | Interior | Homepage and Colophon |
| --- | --- | --- |
| Paper / `--page-bg-colour` | `#faf9f5` | `#3d4340` |
| Reading ink / `--text-colour` | `#333333` | `#f7f7f8` |
| Identity ink / `--masthead-text-colour` | `#332f2b` | `#f7f7f8` |
| Accent / `--accent-colour` | `#a7471b` | `#fff7d6` |
| Strong accent / `--accent-dark-colour` | `#9c4016` | `#ffe97e` |
| Muted ink / `--muted-text-colour` | `#666666` | `rgba(255, 233, 126, 0.72)` |
| Pale ink / `--pale-text-colour` | `#6f6f6f` | `rgba(255, 233, 126, 0.72)` |
| Endpaper / `--footer-bg-colour` | `#f0efe9` | `#343b38` |

Use accent ink sparingly for links, editorial initials and contextual treatments. Links must be identifiable in context, and keyboard focus must be visible. The interior tokens live in `style.css`; cover overrides live in `cover.css`. The cover masthead rule uses yellow ink at 30% opacity. The footer printer’s mark and the larger Colophon illustration share the cover ink.

### Reading rhythm and responsive geometry

| Role | Value |
| --- | --- |
| Default reading type | Inter, 1.125rem, weight 350, line-height 1.55, tracking -0.005em |
| Reading measure | 38em |
| Base site width | 800px |
| Horizontal page padding | clamp(1.25rem, 4vw, 2rem) |
| Wide layout breakpoint | 76rem |
| Marginal reference measure | 14rem |
| Gap to marginal references | 2.25rem |
| Intro-to-content spacing | clamp(2.25rem, 5vw, 3.75rem) |

These are shared reading and layout values, not a prescribed universal spacing scale. Preserve the responsive measure, normal paragraph rhythm and margins rather than introducing arbitrary local overrides. At narrower widths marginal references return to the reading flow.

### Share a stable page frame

At wide desktop sizes, the masthead and footer share one centred frame across every page, including the homepage and Colophon. Their width and horizontal position should remain stable when navigating between cover and interior pages. The masthead contains the site name and description; global navigation and search sit in the shared footer. The cover palette can change without changing that geometry.

The frame contains the article reading column, the gap and the marginal references: 944 pixels at the default text size, with a 684-pixel reading column. Large landscape images can span that frame. Smaller originals retain their intrinsic size, and an 800-pixel maximum image height keeps portraits proportionate without cropping. Captions retain their established reading measure. This wider arrangement starts at the same 76rem breakpoint as marginal references; narrower layouts retain their existing measures.

Content does not have to fill the frame. The homepage uses a 736-pixel measure, aligned to the frame's left edge with the masthead and other pages' main content. The introduction, passages, Latest and footer copy share that edge. The curated passages are separated by white space alone; Latest is a single left-aligned title list. Article and Colophon prose retain their normal reading measure. Archive and other listing content also keep their established widths. The frame accommodates different content measures rather than stretching every paragraph to fill it.

### Use hierarchy without noise

Scale, weight, spacing and position should establish hierarchy before borders, boxes or colour are introduced. Orange is an accent, not a general decoration. Pale and muted text should indicate genuinely secondary information without compromising legibility.

Whitespace should separate ideas and page regions. Avoid filling space merely to make a page feel designed.

The homepage uses a single prose column, four stepped reading sizes and modest paragraph spacing. The first passage receives the opening treatment; subsequent passages settle into a consistent reading scale. Latest is a distinct chronological postscript, with a small Nitti heading, a short rule and Tungsten titles.

### Reuse patterns

Use the existing treatments for inline links, navigation, tags, dates, captions, article listings and archive listings. A new page should look as though it belongs to the same publication, not as though it carries an embedded microsite.

If a new visual role is genuinely needed, define it once, name it according to its purpose and check it alongside related patterns.

The homepage is intentionally a special cover treatment, but it remains part of the same system. The homepage and Colophon share a charcoal cover palette with light text and pale-yellow accents; interior pages retain the warm off-white palette. Shared typography, masthead, navigation and page measure provide continuity without requiring identical colours on every page.

## Typographic roles

HTML heading levels express document structure. Visual classes express appearance. Choose the correct semantic element first, then apply an established visual role where necessary. Do not select `h1`, `h2` or `h3` merely to obtain a particular size.

Use one `h1` for the page's principal subject, then `h2` for its major divisions and `h3` for subdivisions within those sections. Do not skip levels merely to obtain a preferred appearance. The homepage has a visually hidden `h1` identifying the page without adding a visible page heading above its short introduction and selected writing.

The following roles connect semantic structure with visual treatment.

| Role | Markup and existing pattern | Visual treatment | Use |
| --- | --- | --- | --- |
| Site identity | A home-page link containing the site title; `.site-logo` | Tungsten semibold, very large and compact | The masthead only. It identifies the publication but is not the page's `h1`. |
| Site description | Shared header text supplied through template configuration | Small supporting text beneath the name | Describes the whole site on every page; it is not a homepage selection label. |
| Homepage semantic title | `h1.visually-hidden` inside `.home-narrative` | Visually hidden but available to assistive technology | Identifies the homepage without inserting a visible title ahead of the selected writing. |
| Homepage introduction | `.narrative-intro` embedding `Pages/Home.md` | Short supporting prose above the selection | Eases readers into the writing without adding a biography or a second page heading. |
| Homepage narrative passage | `.narrative-passage > p` containing `.narrative-summary-link` | Inter at an enlarged reading scale; the first passage is larger and receives the Tungsten drop cap in the cover's yellow accent (`--accent-dark-colour`) | The primary homepage content and the single visible article link. |
| Homepage lead-in | `.lead-in` from `HomepageLead:` in the first passage | Inter 600, all-small-caps, 0.035em tracking | Optional natural opening phrase, integrated into the first passage. |
| Latest heading | `.homepage-latest > h2` | Nitti regular, 0.875rem | Introduces the chronological postscript. |
| Latest article title | `.homepage-latest-item-title` | Tungsten regular at medium display scale | Single left-aligned list of the latest posts. |
| Homepage article title | `.visually-hidden` inside `.narrative-summary-link` | No visible layout footprint; title-only fallback remains visible | Identifies the article in the same accessible link name, without creating a second focusable destination. |
| Homepage publication date | `time.narrative-date.visually-hidden` or `time.homepage-latest-item-date.visually-hidden` | No visible layout footprint | Retains the original publication date and machine-readable datetime in both sections. |
| Article title | `.entry:has(.post-tags) > h1` | Tungsten regular, large display scale | The title of a tagged essay, note, paper or life entry. Notes use a slightly smaller maximum scale. |
| Functional page title | A direct-child `h1` matched by `main > h1`, `body > h1` or `.entry > h1:first-child` | Nitti regular, small, uppercase and pale | Titles such as Writing, tagged views, Search results, About, Talking and Colophon. The small appearance does not reduce their semantic status. |
| Error message title | `.error-page h1.page-title` | Tungsten regular, large display scale | The principal error message on the error page. Use this display role for the principal error message. |
| Section or item heading | `h2`; talk titles also match `.talk h2` | Tungsten regular at the medium display scale | A major division within an article or substantial page, or the title of an individual talk within the Talking page. |
| Subsection heading | `h3` | Inter 600 at 1.125rem within papers; elsewhere no explicit site-wide typographic rule | Use beneath an `h2` only when the document genuinely needs another level. Outside papers, use the normal heading treatment. |
| Contextual kicker | `.page-kicker`; currently a `p` above the error title | Nitti regular, small, uppercase and pale | Supplementary context above a true title. The Search results `h1` reuses this class but remains the page's functional title. |
| Section label | `.section-label`, for example the labels above individual talks | Small Nitti with a restrained orange wash | Short context for a section or item. It is not itself a heading level and should not replace one where structure requires a heading. |
| Taxonomy chip | `a.section-label.post-tag`; archive tags also use `.archive-entry-tag` | Small Nitti with a restrained orange wash; archive tags are smaller | Linked article types and tags. Do not use this treatment as a generic badge. |
| Listing title | `.row-title` inside `a.row`, or an `a.archive-entry-title` | Tungsten regular at the medium display scale | Article titles in older paginated entry lists, archive, tagged and search listings. These titles are links rather than heading elements. |
| Article or archive date | `.post-date` and `.archive-entry-date` | Small Nitti in a pale colour | Publication dates on individual entries and in archive or tagged listings. |
| Search-result or legacy list date | `.row-date` | Small inherited Inter in a pale colour | Compact dates attached to row-based listing links. This does not describe the homepage, where dates are visually hidden. |
| Caption | `.caption`; `.about-portrait > figcaption` for the authored portrait caption | Small pale Nitti with a restrained orange rule | Supporting text associated with an image. |
| Editorial opening initial | First letter of a marked opening paragraph | Uppercase Tungsten 600, accent ink, approximately three lines deep | Marks the beginning of an essay or personal article without changing its source text. |
| Editorial lead-in | `.lead-in` on an explicitly marked opening phrase | Inter 600, all-small-caps, 0.035em tracking, reading ink | A short editorial phrase integrated into the first paragraph, not a heading or standfirst. |
| Body and summary text | `body`, `.row-summary`, `.archive-entry-summary` and `.talk-description` | Inter, with summaries smaller and muted | Reading text and supporting descriptions. |

The exact sizes, line heights, colours and responsive ranges live in `style.css` and, for the narrative homepage, `homepage.css`. When those values change, judge them in the rendered page and in relation to neighbouring text. Update this guide when the meaning or responsibility of a role changes.

The human-readable RSS view has its own typography in `pretty-feed.xsl`; it does not define roles for the site's HTML templates.

## Published papers

Papers are records of published work, rather than essays with a different tag. Preserve their original authorship and author order, publication history and text. Use the shared article title, reading measure, image and caption styles, but not the editorial drop initial or small-cap lead-in.

A compact bibliographic header immediately after the title groups the information needed to understand and access the work:

| Role | Class | Treatment |
| --- | --- | --- |
| Header | `paper-header` | Reading-column width, quiet bottom rule and 75% of the shared intro-to-content spacing before the text |
| Authors | `paper-authors` | Inter, 1rem, weight 450, sentence case, wrapping naturally |
| Venue and publication date | `paper-publication` | Muted Nitti, 0.85rem, normal case |
| Award or distinction | `paper-award` | Same contextual treatment as publication information |
| Access links | `paper-access` | Nitti, 0.875rem, standard accent links; wrap at narrow widths |
| Formal citation | `paper-citation` | Separate closing section when a citation is available; muted Nitti, 0.875rem, with a compact Nitti 0.875rem heading (semantic h2) and linked DOI where known |

Use a semantic header with paragraphs and ordinary anchors; omit unavailable information rather than creating empty rows. Put PDF, slides and original publication links near the title even when the complete paper is reproduced on the site. Keep the formal citation separate from the shorter publication information, and preserve all original bibliographic facts. Do not manufacture a citation or infer missing authors from the site byline. Do not introduce buttons, cards, a citation generator or another template merely for this small collection.

Paper subsection headings (`h3`) use Inter 600 at 1.125rem with a 1.4 line height. They are subordinate to the existing Tungsten `h2`, without changing heading semantics. This treatment is specific to papers.

Abstracts use normal reading weight; the Abstract heading already establishes their role. Papers use the shared tagged listing presentation.

## Interaction and component guidance

Links should normally look and behave like links. Broad global rules may provide a baseline, but specialised treatments such as the masthead, menu, tags, listings and homepage narrative should remain visually coherent with their purpose.

On the homepage, the passage and its title share a single anchor to the article. The visually hidden title follows the prose inside that anchor and remains part of its accessible name; a title-only fallback is visible. Keep one keyboard focus target per passage.

Homepage passage and Latest links, and footer links on both covers, use the shared text-colour reveal in `cover.css`. Hover and focus reveal the pale-yellow accent within the text, with solid yellow as the fallback and immediate feedback on touch. The treatment does not move text or change layout. Keep a visible focus outline, respect reduced-motion preferences and preserve legibility in forced-colour and print modes. The masthead and search retain their ordinary treatments.

Buttons are for actions; links are for navigation. Do not style a link as a button simply to give it greater prominence. Do not introduce a button where selecting or following ordinary text would work.

Navigation should remain short and stable. The masthead links home. Global navigation lives in the footer in two columns: Writing, Talking and About; Search, Colophon and RSS. Navigation links are capitalised, the author credit stays in sentence case and Search is a quiet, borderless field with an accessible hidden label and native Enter submission. The footer retains the query and displays it in capitals. Bluesky belongs on informational pages rather than in global navigation.

The footer acts as a gently contrasting endpaper: deeper charcoal on the homepage and Colophon, warm-grey off-white on interior pages. Its background spans the viewport, while its contents retain the same shared frame. The decorative octopus appears beside the author credit as a shared printer’s mark.

Images should support the writing. Captions use the established Nitti treatment and orange rule. Decorative imagery should be rare. The octopus is the shared footer's recurring closing mark. A larger illustration accompanies the Colophon's explanation of the mark; it is part of that page's content.

Informative images need concise descriptions in alt text, with captions and credits kept separate. Native Markdown uses `![Description](image.jpg "Caption and credit")`. Keep caption titles as plain text, without Markdown italics. Decorative images retain empty alt text.

The About portrait's manually authored `figcaption` deliberately has no `caption` class, allowing Blot to preserve it without adding another caption. Scoped CSS applies the established caption treatment.

### Sources and connections

Keep citations as ordinary titled source links at the end of a paragraph in the authored document. At wide widths, qualifying citations appear in the right margin in compact Nitti; at narrower widths or without JavaScript they remain inline. The source and its title provide context without breaking the reading rhythm. Links that belong to the sentence, and download actions, stay inline.

Default to one-way archive connections; reciprocal links are not automatic. One `archive-connection` aside per essay is the default ceiling, not a target. Prefer an inline link when it belongs naturally in the prose. Any additional aside needs a specific editorial reason beyond topical relevance or reciprocity. Review the cumulative demands on the reader before adding or activating a connection; see [Connections within the archive](docs/writing-and-editorial-style.md#connections-within-the-archive).

An editorial connection to another article can appear at the relevant point in the reading column. The `archive-connection` aside uses the label “Elsewhere in the archive”, a linked article title and a brief explanation of the connection. A quiet accent rule and smaller text distinguish it from the argument. These are authored relationships between pieces of writing, not automatically generated recommendations or a compulsory end-of-article module.

## Changing the site

Start with a reader or publishing need. Make changes at the appropriate layer, prefer an established pattern, and preserve URLs, semantic markup, accessibility and machine-readable formats. The design should continue to feel like a publication rather than a generic product interface.

Verify changes in the rendered site across affected page types and viewport widths, including both cover palettes and keyboard navigation. Detailed implementation and regression-check guidance belongs in `Templates/index/AGENTS.md` and the companion homepage guide. This document describes the intended design, not the sequence of experiments used to arrive at it.

## Maintaining this guide

Change this document when a principle is settled, a visual role is deliberately introduced, or repeated work reveals a genuine pattern. Do not expand it for every isolated exception.

Keep proposals, experiments and implementation issues outside this guide until they result in an adopted design decision. Git history retains the record of earlier versions.
