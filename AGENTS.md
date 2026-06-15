# AGENTS.md

This repository contains the Blot template and supporting files for `tomscott.name`.

It is a personal site built on Blot. Treat it as a Blot template, not as a conventional static-site-generator project. Do not assume Eleventy, Jekyll, Hugo, Astro, Next.js, React, Tailwind, Sass, TypeScript, a bundler, or a build step unless one is explicitly present.

## Official Blot references

Use the official Blot documentation when you are unsure how Blot behaves.

- Blot documentation: https://blot.im/how
- Blot developer reference: https://blot.im/developers/reference
- How Blot works: https://blot.im/developers/tutorials/how-blot-works
- Local template development: https://blot.im/developers/get-started
- Working with AI on Blot templates: https://blot.im/developers/guides/working-with-ai
- Embedding rendered files in templates: https://blot.im/developers/examples/embed-file

Do not infer behaviour from another static site framework when the Blot documentation gives a different answer.

## Blot template context

Blot creates a site from files in a synced folder. Files become posts, pages, assets, or template files depending on their location and metadata.

This repository is concerned mainly with the template layer. A Blot template contains Mustache views, template configuration, CSS, and optional lightweight client-side JavaScript.

Important files commonly include:

- `package.json` — template configuration.
  - `locals` defines template-wide variables exposed to views.
  - `views` defines routing for template files through `url`.
  - per-view `partials` may define string partials for titles, descriptions, or other view-specific template fragments.
- `entries.html` — homepage or entry-list view.
- `entry.html` — individual article/post view.
- `archives.html` — archive listing view, commonly routed to `/archives`.
- `tagged.html` — tag listing view, commonly used for `/tagged/:tag` routes.
- `search.html` — search results view, if present.
- `error.html` — error or 404 view, if present.
- `head.html`, `header.html`, `footer.html` — reusable partials, if present.
- `style.css` — main stylesheet. Keep it as plain CSS.
- `script.js` — optional client-side behaviour. Keep it small and non-essential.

Check the actual files in the repository before assuming that any of these are present.

If you are unsure which view maps to which URL, open `package.json` and check `views[*].url`.

## Template language

Templates use Mustache.

Mustache variables are HTML-escaped by default. Use normal double braces unless the value is known to be safe and is expected to contain HTML or path-like content.

Examples:

```mustache
{{title}}
{{date}}
{{summary}}
```

Use triple braces only where Blot expects unescaped output, commonly for rendered entry HTML or URL/path values that are already trusted in this context.

Examples:

```mustache
{{{url}}}
{{{path}}}
{{{body}}}
{{{html}}}
```

Do not replace Mustache syntax with Liquid, Handlebars, JSX, Nunjucks, or another templating language.

## Partials

Blot templates can use file partials, per-view string partials, and rendered site-file embeds.

File partials include another template file and inherit the current context.

```mustache
{{> header}}
{{> footer}}
```

Per-view string partials are defined in `package.json` under the relevant view and can be included with the same Mustache partial syntax.

```mustache
{{> title}}
{{> description}}
```

Rendered site files can also be embedded. For example:

```mustache
{{> /Pages/Home.md}}
{{> /Pages/Writing.md}}
```

This embeds the rendered HTML output of the file, not the raw Markdown source. If the file does not exist, Blot inserts an empty string.

## Blot-specific constraints

Keep template view files in the template root. Do not create subdirectories for template view files unless Blot documentation explicitly supports the pattern being used.

Do not introduce SCSS, Sass, PostCSS, TypeScript, bundlers, generated asset pipelines, or package build scripts unless explicitly requested.

The blog routes templates before serving static files. Avoid adding a view whose `url` conflicts with an existing post or page path unless that conflict is intentional.

Avoid view-name collisions. Do not create two views with the same basename, such as `feed.xml` and `feed.rss`.

When adding or changing a route, update `package.json` and check that the route does not collide with an existing page, post, redirect, or asset path.

## Development and testing

Use `?json=true` on any page to inspect the JSON context Blot provides to the template.

Examples:

```text
https://tomscott.name/?json=true
https://tomscott.name/archives?json=true
https://tomscott.name/search?q=design&json=true
https://tomscott.name/tagged/essay?json=true
```

Use the JSON context to confirm property names before changing template logic. Do not guess whether a property exists.

After a template or CSS change, verify the rendered page, not just the source file.

Check at least the page you changed and any shared views that might be affected. For site-wide CSS, navigation, typography, links, summaries, tags, or spacing, check:

- homepage;
- individual article page;
- archive page;
- tagged page;
- search page;
- error page;
- mobile layout.

For asset issues, check the rendered CSS, font, and JavaScript URLs in the browser. Blot, iCloud sync, and CDN routing can make asset paths behave differently from local paths.

## Workflow expectations

Keep changes minimal, deliberate, and backwards-compatible.

Prefer small patches over broad rewrites.

Do not make unrelated cleanups while fixing a specific issue.

When proposing a change, explain:

- which file to edit;
- what to replace or add;
- why the change is safe;
- what pages to test afterwards.

For small changes, provide complete replacement snippets.

For larger changes, provide a patch or clearly marked before-and-after blocks.

Do not assume that pushing to GitHub automatically deploys to Blot. The site may be synced through iCloud or another Blot-supported sync mechanism. Treat the live Blot sync path as the deployment source unless the user says otherwise.

## CSS conventions

Use plain CSS.

Prefer existing classes, selectors, spacing patterns, and typographic conventions before adding new ones.

Avoid large-scale refactors of `style.css` unless explicitly requested.

Keep spacing, typography, link styling, captions, tags, archive rows, search forms, and navigation visually consistent across the site.

Known visual conventions include:

- The site is intentionally restrained and typographic.
- The masthead is styled as `TOMSCOTT.name`.
- The masthead/logo links to the homepage, so the navigation does not need a separate Home item.
- Tungsten is used for prominent headings and masthead treatments.
- Inter is used for body text.
- Nitti is used for captions or technical/supporting text where already established.
- Orange is used as the site accent colour.
- Tags and pill links should feel like part of the site’s visual system.
- Tag/pill links should not gain unrelated underline treatments.
- Search should feel integrated with the navigation and site typography.

Do not add decorative complexity unless it clearly improves the design.

## HTML and accessibility

Prefer semantic HTML.

Use accessible patterns for navigation, search, forms, headings, links, and error pages.

Keep client-side JavaScript optional. The site should remain usable when JavaScript is disabled.

Do not rely on JavaScript for core navigation, reading, search form submission, or access to article content unless explicitly requested.

## Content and editorial conventions

Do not rewrite site copy unless asked.

When drafting or editing copy for the site, use clear, direct, natural language.

Avoid marketing language, filler, clichés, and generic AI-sounding phrasing.

Use sentence case for headings.

Use British English for personal-site content unless the surrounding page clearly uses American English or the user asks otherwise.

Preserve the author’s voice. The site should sound like Tom Scott, not like a product landing page.

## Common debugging patterns

For layout bugs, inspect both the template source and the rendered HTML.

For Blot rendering issues, compare:

- source Markdown;
- rendered HTML;
- `?json=true` context;
- template logic;
- CSS selectors.

For list pages, confirm whether the page is using `entries`, `recent_entries`, `all_entries`, `archives`, `tagged`, or a paginated context before changing loops.

For tag pages, check the effective tagged route context before assuming the same pagination behaviour as the homepage.

For summaries, confirm whether the template is using a manually supplied summary, Blot’s generated `summary`, rendered `teaser`, or another property.

For embedded page content, remember that `{{> /Pages/File.md}}` inserts rendered HTML and may be affected by the page’s metadata.

For CSS or font-loading problems, confirm whether assets are being loaded from the intended URL, whether the CDN is rewriting the path, and whether relative paths still resolve correctly after Blot processes the template.

## Things not to do

Do not add a build system.

Do not convert the site to a different framework.

Do not reorganise the template into nested directories.

Do not replace the design system with utility classes or a CSS framework.

Do not change typography, spacing, link behaviour, or navigation structure as an incidental side effect.

Do not hard-code content into templates when it belongs in a page or post.

Do not expose private files, credentials, tokens, local paths, or unpublished drafts.

Do not treat every file in the synced Blot folder as private. Blot’s site folder can expose files publicly depending on path and naming.

## Preferred answer style for agents

Be direct and specific.

State assumptions clearly.

When uncertain, say what to check rather than pretending to know.

Prefer one safe, well-explained recommendation over several speculative options.

Where a change has possible side effects, name the pages or behaviours most likely to be affected.
