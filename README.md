# tomscott.name templates

This repository contains the custom design files for [tomscott.name](https://tomscott.name), my personal site.

The site is published with [Blot](https://github.com/davidmerfield/blot). Blot provides the publishing system; this repository contains the templates, CSS, and supporting files I use to customise the design and behaviour of the site.

## What is in this repo

The repository includes the main Blot templates for the site, including the homepage, article pages, archive pages, tagged pages, search results, and error pages.

It also includes the shared template partials for the document head, header, and footer, along with the site stylesheet and a small amount of JavaScript.

Supporting files include `robots.txt`, `humans.txt`, `security.txt`, `sitemap.xml`, and `feed.rss`.

## Design notes

The site is intentionally simple. It is mostly text, with a small number of typographic and structural choices doing most of the design work.

The design uses a strong masthead, a restrained navigation, wide readable article layouts, compact archive and tag pages, and a small set of recurring visual motifs, including section labels, tags, captions, and orange accent rules.

The templates have been adapted to support summaries, tagged views, search results, article metadata, captions, and lightweight navigation between posts.

## How the site works

Content is managed in Blot. These files are the theme layer that controls how that content is rendered.

The key files are:

* `entries.html` controls the homepage and main list of recent entries.
* `entry.html` controls individual article pages.
* `archives.html` controls the archive page.
* `tagged.html` controls tag pages.
* `search.html` controls search results.
* `head.html`, `header.html`, and `footer.html` are shared partials.
* `style.css` contains the main visual design.
* `script.js` contains small client-side enhancements.
* `package.json` contains Blot configuration for views, page sizes, titles, and descriptions.

## Local development

This repository is not a standalone static site generator. It is designed to be used with Blot.

To work on the design, edit the relevant template or CSS file, then upload or sync the change to Blot. The rendered site should then be checked directly at [tomscott.name](https://tomscott.name).

## Notes

This is a personal site rather than a general-purpose Blot theme. You are welcome to look around, borrow ideas, or adapt small pieces. The code and template layer is shared under AGPL-3.0, while my own writing is generally available under CC BY unless otherwise stated.

## Licence

This repository contains template, stylesheet, script, and configuration files for [tomscott.name](https://tomscott.name), a personal site published with Blot.

Blot is licensed under the GNU Affero General Public License v3.0. The template, stylesheet, script, and configuration files in this repository are therefore licensed under the GNU Affero General Public License v3.0, to the extent that they are derived from or adapted from Blot’s templates or code.

Unless otherwise stated, my own writing on [tomscott.name](https://tomscott.name) is licensed under the Creative Commons Attribution 4.0 International licence.

Typefaces are used under license. 

Images, screenshots, photographs, embedded media, quotations, and other third-party material may be subject to different rights and licences. Where possible, these are credited or licensed alongside the relevant item.
