# Design principles for tomscott.name

This document describes the architectural, editorial and visual principles behind tomscott.name. It is intended to guide changes to the site rather than catalogue every declaration in the stylesheet.

The site should feel like a small, considered publication. The writing is the main event. Design gives it structure, rhythm and identity without turning the site into a product interface or a stream of interchangeable content.

The current implementation is evidence, not automatically precedent. Where the templates are inconsistent, this guide should clarify the intended system rather than preserve an accident. The homepage has its own more detailed guide at [`homepage.md`](homepage.md); where the two documents overlap, that guide records the current homepage-specific decisions.

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

The homepage is a curated introduction to the writing. It should not simply expose the newest posts, repeat the archive, or behave like a dashboard of content cards.

Its selected passages should let readers encounter ideas before metadata. The passage itself is the visible article destination; article titles are retained within the link's accessible text rather than repeated visually. Selection should favour a coherent range of strong long-form pieces rather than optimise mechanically for recency or completeness. The archive, tagged views and feed remain the places for comprehensive and chronological discovery.

The current homepage deliberately begins with the writing rather than an introductory biography. Do not restore explanatory copy, visible article titles, category labels, cards, or other interface merely to make the page explain itself more explicitly.

### Keep taxonomy in proportion

Article types and tags support organisation and browsing. They do not need to be repeated wherever an article appears. Use taxonomy on archive, tagged and other discovery pages when it helps readers make a choice; keep the homepage focused on the selected prose and publication date, while preserving the article title accessibly in the link markup.

### Earn every piece of interface

Do not add an element simply because it might be useful in isolation. Consider the accumulated effect on the site's character, the attention it takes from the writing and the maintenance burden it creates.

### Write in the site's voice

Use clear, direct British English. Avoid marketing language, generic calls to action and copy that sounds like a product onboarding flow. Interface text should be calm and specific.

## Visual principles

### Typography does most of the work

The design uses three type families with broadly distinct responsibilities:

- Inter is the reading face for body copy and supporting prose, including the narrative passages on the homepage.
- Tungsten is the display face for the masthead, article titles, and section headings.
- Nitti supplies most of the compact contextual furniture: navigation, page labels, tag treatments, captions, article and archive dates, homepage dates, and code.

These are roles rather than universal rules. For example, search-result dates currently inherit Inter, while the larger error message is set in Tungsten.

Do not choose a face only for novelty or contrast. Each use should reinforce an established role. Optical harmony with surrounding text takes precedence over matching a nominal numerical size.

### Use hierarchy without noise

Scale, weight, spacing and position should establish hierarchy before borders, boxes or colour are introduced. Orange is an accent, not a general decoration. Pale and muted text should indicate genuinely secondary information without compromising legibility.

Whitespace should separate ideas and page regions. Avoid filling space merely to make a page feel designed.

On the homepage, preserve the hierarchy in which the prose is the only visible article destination and the smaller Nitti date is metadata beneath it. The article title remains part of the link's accessible text but has no visual typographic role on the homepage. Do not recreate the superseded marginal-reference, desktop title-column, or visible-title treatments without a new demonstrated need.

### Reuse patterns

Use the existing treatments for inline links, navigation, tags, dates, captions, article listings and archive listings. A new page should look as though it belongs to the same publication, not as though it carries an embedded microsite.

If a new visual role is genuinely needed, define it once, name it according to its purpose and check it alongside related patterns.

The homepage is intentionally a special cover treatment, but it remains part of the same system. Its yellow background, warm charcoal text and rust links are scoped to `html.home-cover`; the rest of the site retains the shared off-white palette. Shared typography, masthead, navigation and page measure provide continuity without requiring identical colours on every page.

## Typographic roles

HTML heading levels express document structure. Visual classes express appearance. Choose the correct semantic element first, then apply an established visual role where necessary. Do not select `h1`, `h2` or `h3` merely to obtain a particular size.

Use one `h1` for the page's principal subject, then `h2` for its major divisions and `h3` for subdivisions within those sections. Do not skip levels merely to obtain a preferred appearance. The homepage has a visually hidden `h1` identifying the page while allowing the selected writing to remain the visible opening.

The table below records the effective result of the current selectors and their actual template usage. It does not treat an unused declaration as an established design role.

| Role | Markup and existing pattern | Visual treatment | Use |
| --- | --- | --- | --- |
| Site identity | A home-page link containing the site title; `.site-logo` | Tungsten semibold, very large and compact | The masthead only. It identifies the publication but is not the page's `h1`. |
| Homepage semantic title | `h1.visually-hidden` inside `.home-narrative` | Visually hidden but available to assistive technology | Identifies the homepage without inserting a visible title ahead of the selected writing. |
| Homepage narrative passage | `.narrative-passage > p` containing `.narrative-summary-link` | Inter at an enlarged reading scale; the first passage is larger and receives the Tungsten drop cap | The primary homepage content and the single visible article link. |
| Homepage article title | `.narrative-link-title` inside `.narrative-summary-link` | Visually hidden | Preserves the article title in the passage link's accessible text without creating a second visible or focusable destination. |
| Homepage publication date | `.narrative-date` | Small Nitti in a restrained charcoal | Right-aligned publication metadata beneath the homepage passage. |
| Article title | `.entry:has(.post-tags) > h1` | Tungsten regular, large display scale | The title of a tagged essay, note, paper or life entry. Notes use a slightly smaller maximum scale. |
| Functional page title | A direct-child `h1` matched by `main > h1`, `body > h1` or `.entry > h1:first-child` | Nitti regular, small, uppercase and pale | Titles such as Writing, tagged views, Search results, About, Talking and Colophon. The small appearance does not reduce their semantic status. |
| Error message title | `.error-page h1.page-title` | Tungsten regular, large display scale | The principal error message on the error page. This is the only current use of `.page-title`. |
| Section or item heading | `h2`; talk titles also match `.talk h2` | Tungsten regular at the medium display scale | A major division within an article or substantial page, or the title of an individual talk within the Talking page. |
| Subsection heading | `h3` | No explicit site-wide typographic rule; it would inherit Inter and retain the browser's default heading size and weight | Use beneath an `h2` only when the document genuinely needs another level. Published content does not currently use this level, although a legacy draft uses it extensively; review that material before establishing a shared treatment. |
| Contextual kicker | `.page-kicker`; currently a `p` above the error title | Nitti regular, small, uppercase and pale | Supplementary context above a true title. The Search results `h1` reuses this class but remains the page's functional title. |
| Section label | `.section-label`, for example `Latest words` and the labels above individual talks | Small Nitti with a restrained orange wash | Short context for a section or item. It is not itself a heading level and should not replace one where structure requires a heading. |
| Taxonomy chip | `a.section-label.post-tag`; archive tags also use `.archive-entry-tag` | Small Nitti with a restrained orange wash; archive tags are smaller | Linked article types and tags. Do not use this treatment as a generic badge. |
| Listing title | `.row-title` inside `a.row`, or an `a.archive-entry-title` | Tungsten regular at the medium display scale | Article titles in older paginated entry lists, archive, tagged and search listings. These titles are links rather than heading elements. |
| Article or archive date | `.post-date` and `.archive-entry-date` | Small Nitti in a pale colour | Publication dates on individual entries and in archive or tagged listings. |
| Search-result or legacy list date | `.row-date` | Small inherited Inter in a pale colour | Compact dates attached to row-based listing links. This no longer describes the selected homepage, whose date has its own Nitti role. |
| Caption | `.caption` | Small pale Nitti with a restrained orange rule | Supporting text associated with an image. |
| Body and summary text | `body`, `.row-summary`, `.archive-entry-summary` and `.talk-description` | Inter, with summaries smaller and muted | Reading text and supporting descriptions. |

The exact sizes, line heights, colours and responsive ranges live in `style.css` and, for the narrative homepage, `homepage.css`. When those values change, judge them in the rendered page and in relation to neighbouring text. Update this guide when the meaning or responsibility of a role changes.

The base `.page-title` rule declares Tungsten semibold, but every current use is inside `.error-page`, whose more specific rule changes the weight to regular. Semibold `.page-title` is therefore dormant CSS, not a current typographic role. The human-readable RSS view is also separate: `pretty-feed.xsl` embeds its own CSS and uses semibold Tungsten for its `h1` and `h2`; that does not establish a role for the site's HTML templates.

## Interaction and component guidance

Links should normally look and behave like links. Broad global rules may provide a baseline, but specialised treatments such as the masthead, menu, tags, listings and homepage narrative should remain visually coherent with their purpose.

On the homepage, the passage is the single visible anchor to its article. It responds through a colour change and visible keyboard focus rather than an underline or card treatment. The article title is appended inside that same anchor as visually hidden text so it remains available in the link's accessible name. Do not reintroduce a second hidden or visible title link, replace the anchor with a JavaScript click handler, or make the entire passage container an interactive component.

Buttons are for actions; links are for navigation. Do not style a link as a button simply to give it greater prominence. Do not introduce a button where selecting or following ordinary text would work.

Navigation should remain short and stable. The masthead already links home, so a separate Home item is unnecessary. Search should feel like part of the navigation rather than a separate application interface.

Images should support the writing. Captions use the established Nitti treatment and orange rule. Decorative imagery should be rare; the printer's mark already provides a recurring closing motif. The octopus does not need to be repeated in the masthead.

## Before changing the site

Ask the following questions before implementation:

1. What reader need or publishing need has been demonstrated?
2. Which existing web, editorial or repository contract could this affect?
3. Is the change being made at the correct layer?
4. Can an existing pattern solve the problem without introducing a new one?
5. Does the result remain meaningful without CSS and usable without JavaScript?
6. Does it preserve stable URLs, semantic markup and machine-readable formats?
7. Does it make the site feel more like this publication, or more like a generic product or content feed?
8. Which live pages, clients and viewport sizes must be checked afterwards?

When these questions reveal a tension, preserve the architectural and editorial principles before optimising convenience or visual novelty.

For homepage changes, also ask whether the change preserves the intended reading hierarchy: prose first, publication date second, with the article title retained accessibly rather than visually. Treat the single-column treatment, lack of introductory biography, absence of visible article titles, and curated selection as settled decisions unless a new problem provides a reason to revisit them.

## Maintaining this guide

Change this document when a principle is settled, a visual role is deliberately introduced, or repeated work reveals a genuine pattern. Do not expand it for every isolated exception.

Unresolved questions should remain explicit. At present, published content does not use `h3` and the site has no settled typographic treatment for it; the generic semibold `.page-title` declaration is unused after the error-page override; and the semantic structure of titles inside row-based article listings deserves review before it is standardised further.
