# Design principles for tomscott.name

This document describes the architectural, editorial and visual principles behind tomscott.name. It is intended to guide changes to the site rather than catalogue every declaration in the stylesheet.

The site should feel like a small, considered publication. The writing is the main event. Design gives it structure, rhythm and identity without turning the site into a product interface or a stream of interchangeable content.

The current implementation is evidence, not automatically precedent. Where the templates are inconsistent, this guide should clarify the intended system rather than preserve an accident.

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

The iCloud Drive folder used by Blot is the canonical working copy. The private GitHub repository records the complete site. The public template repository is derived from selected parts of that private source.

Do not maintain parallel editable versions of templates or assets. Changes should travel in one direction through the documented publication workflow.

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

### Keep taxonomy in proportion

Article types and tags support organisation and browsing. They do not need to be repeated wherever an article appears. Use taxonomy on archive, tagged and other discovery pages when it helps readers make a choice; keep homepage listings focused on titles and summaries.

### Earn every piece of interface

Do not add an element simply because it might be useful in isolation. Consider the accumulated effect on the site's character, the attention it takes from the writing and the maintenance burden it creates.

### Write in the site's voice

Use clear, direct British English. Avoid marketing language, generic calls to action and copy that sounds like a product onboarding flow. Interface text should be calm and specific.

## Visual principles

### Typography does most of the work

The design uses three type families with distinct responsibilities:

- Inter is the reading face for body copy and supporting prose.
- Tungsten is the display face for the masthead, article titles and prominent headings.
- Nitti is the technical and contextual face for navigation, dates, labels, captions and code.

Do not choose a face only for novelty or contrast. Each use should reinforce an established role. Optical harmony with surrounding text takes precedence over matching a nominal numerical size.

### Use hierarchy without noise

Scale, weight, spacing and position should establish hierarchy before borders, boxes or colour are introduced. Orange is an accent, not a general decoration. Pale and muted text should indicate genuinely secondary information without compromising legibility.

Whitespace should separate ideas and page regions. Avoid filling space merely to make a page feel designed.

### Reuse patterns

Use the existing treatments for inline links, navigation, tags, dates, captions, article listings and archive listings. A new page should look as though it belongs to the same publication, not as though it carries an embedded microsite.

If a new visual role is genuinely needed, define it once, name it according to its purpose and check it alongside related patterns.

## Typographic roles

HTML heading levels express document structure. Visual classes express appearance. Choose the correct semantic element first, then apply an established visual role where necessary. Do not select `h1`, `h2` or `h3` merely to obtain a particular size.

Every document should have one principal `h1`. Subsequent headings should follow a meaningful hierarchy without skipping levels.

| Role | Markup and existing pattern | Visual treatment | Use |
| --- | --- | --- | --- |
| Site identity | A home-page link containing the site title; `.site-logo` | Tungsten semibold, very large and compact | The masthead only. It identifies the publication but is not the page's `h1`. |
| Article title | The first `h1` in `.entry` when post tags are present | Tungsten regular, large display scale | The title of an essay, note, paper or life entry. Notes use a slightly smaller maximum scale. |
| Functional page title | `h1` using the page-label treatment | Nitti regular, small, uppercase and pale | Short navigational titles such as Writing, Search results, About and Colophon. The small appearance does not reduce its semantic status. |
| Expressive page title | `h1.page-title` | Tungsten semibold, large display scale | Exceptional pages whose principal title needs rhetorical prominence. Do not use it merely to make a utility page more dramatic. |
| Article section | `h2` | Tungsten regular at the medium display scale | A major division within an article or substantial page. |
| Article subsection | `h3` | No distinct site-wide treatment has yet been settled | Use only beneath an `h2`. Before introducing new `h3` styling, review the older papers that already use this level and establish one shared treatment. |
| Contextual kicker | `p.page-kicker` or an equivalent non-heading element | Nitti regular, small, uppercase and pale | Supplementary context above a true title. It must not replace the page's semantic `h1`. |
| Taxonomy label | Link or span using `.section-label` or `.post-tag` | Small Nitti with a restrained orange wash | Tags, article types and other genuine taxonomy. Do not use it as a generic badge. |
| Listing title | A link containing `.row-title` or `.archive-entry-title` | Tungsten regular at the medium display scale | Article titles in homepage, archive, tagged and search listings. Preserve a clear accessible name and link target. |
| Metadata | `.row-date`, `.archive-entry-date`, `.post-date` and related patterns | Small Nitti in a pale or muted colour | Dates and supporting publication information. |

The exact sizes, line heights, colours and responsive ranges live in `style.css`. When those values change, judge them in the rendered page and in relation to neighbouring text. Update this guide when the meaning or responsibility of a role changes.

## Interaction and component guidance

Links should normally look and behave like links. Broad global rules may provide a baseline, but specialised treatments such as the masthead, menu, tags and listing rows should remain visually coherent with their purpose.

Buttons are for actions; links are for navigation. Do not style a link as a button simply to give it greater prominence. Do not introduce a button where selecting or following ordinary text would work.

Navigation should remain short and stable. The masthead already links home, so a separate Home item is unnecessary. Search should feel like part of the navigation rather than a separate application interface.

Images should support the writing. Captions use the established Nitti treatment and orange rule. Decorative imagery should be rare; the printer's mark already provides a recurring closing motif.

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

## Maintaining this guide

Change this document when a principle is settled, a visual role is deliberately introduced, or repeated work reveals a genuine pattern. Do not expand it for every isolated exception.

Unresolved questions should remain explicit. At present, the site does not have a settled `h3` treatment, and the semantic structure of titles inside article listings deserves review before it is standardised further.
