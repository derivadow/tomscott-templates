<?xml version="1.0" encoding="UTF-8"?>

<!--
  A human-readable view of the RSS feed. Feed readers ignore this stylesheet.
  Inspired by Pretty Feed: https://github.com/genmon/aboutfeeds
-->
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  exclude-result-prefixes="dc">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><xsl:value-of select="rss/channel/title"/> — RSS feed</title>
        <style>
          @font-face {
            font-family: 'Inter';
            src: url('/fonts/InterVariable.woff2') format('woff2');
            font-weight: 100 700;
            font-style: normal;
            font-display: swap;
          }

          @font-face {
            font-family: 'Nitti';
            src: url('/fonts/Nitti-Regular.woff2') format('woff2');
            font-weight: 400;
            font-style: normal;
            font-display: swap;
          }

          @font-face {
            font-family: 'Tungsten';
            src: url('/fonts/Tungsten-SemiBold.woff2') format('woff2');
            font-weight: 600;
            font-style: normal;
            font-display: swap;
          }

          :root {
            color-scheme: light;
            --text: #333;
            --muted: #777;
            --accent: #e36a29;
            --border: rgba(0, 0, 0, 0.18);
            --background: #faf9f5;
          }

          * {
            box-sizing: border-box;
          }

          html {
            background: var(--background);
          }

          body {
            max-width: 800px;
            margin: 0 auto;
            padding: 2.5rem clamp(1.25rem, 4vw, 2rem) 6rem;
            color: var(--text);
            font: 350 1.125rem/1.55 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            letter-spacing: -0.005em;
          }

          a {
            color: inherit;
            text-decoration-color: rgba(227, 106, 41, 0.55);
            text-decoration-thickness: 1px;
            text-underline-offset: 0.18em;
          }

          a:hover {
            color: var(--accent);
            text-decoration-color: currentColor;
          }

          a:focus-visible {
            outline: 2px solid var(--accent);
            outline-offset: 4px;
          }

          header {
            margin-bottom: clamp(3rem, 8vw, 5rem);
          }

          .masthead {
            display: block;
            padding-bottom: 1.25rem;
            border-bottom: 1px solid rgba(227, 106, 41, 0.35);
            font: 600 clamp(2.7rem, 9vw, 4.15rem)/0.9 'Tungsten', Impact, 'Arial Narrow', sans-serif;
            letter-spacing: 0.008em;
            text-decoration: none;
          }

          .masthead:hover {
            color: inherit;
          }

          .eyebrow,
          time {
            color: var(--muted);
            font-family: 'Nitti', Consolas, 'Liberation Mono', monospace;
            font-size: 0.78rem;
            letter-spacing: 0.02em;
            text-transform: uppercase;
          }

          h1,
          h2 {
            font-family: 'Tungsten', Impact, 'Arial Narrow', sans-serif;
            font-weight: 600;
            line-height: 0.95;
            letter-spacing: 0.005em;
          }

          h1 {
            max-width: 9em;
            margin: 0.6rem 0 1.25rem;
            font-size: clamp(3rem, 10vw, 5.5rem);
          }

          h2 {
            margin: 0;
            font-size: clamp(1.9rem, 5vw, 2.75rem);
          }

          .introduction {
            max-width: 38em;
            margin-bottom: clamp(3.5rem, 9vw, 6rem);
          }

          .introduction p {
            margin: 0 0 1rem;
          }

          .site-link {
            display: inline-block;
            margin-top: 0.35rem;
            font-family: 'Nitti', Consolas, 'Liberation Mono', monospace;
            font-size: 0.86rem;
            letter-spacing: 0.01em;
            text-transform: uppercase;
          }

          .items-heading {
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
          }

          ol {
            margin: 0;
            padding: 0;
            list-style: none;
          }

          li {
            display: grid;
            grid-template-columns: minmax(0, 1fr) auto;
            gap: 0.5rem 2rem;
            align-items: baseline;
            padding: 1.25rem 0 1.4rem;
            border-bottom: 1px solid var(--border);
          }

          li a {
            font-size: clamp(1.1rem, 3vw, 1.3rem);
            font-weight: 600;
            line-height: 1.3;
            text-decoration: none;
          }

          time {
            white-space: nowrap;
          }

          footer {
            margin-top: 3.5rem;
            color: var(--muted);
            font-size: 0.82rem;
          }

          @media (max-width: 34rem) {
            li {
              grid-template-columns: 1fr;
            }
          }
        </style>
      </head>
      <body>
        <header>
          <a class="masthead" href="{rss/channel/link}">TOMSCOTT.name</a>
        </header>

        <main>
          <section class="introduction" aria-labelledby="feed-title">
            <div class="eyebrow">RSS feed</div>
            <h1 id="feed-title"><xsl:value-of select="rss/channel/title"/></h1>
            <p>This page is a web feed: a simple way to follow new writing without an algorithm or an inbox.</p>
            <p>To subscribe, copy this page’s address into a feed reader. If that is new to you, <a href="https://aboutfeeds.com/">About Feeds</a> is a short introduction.</p>
            <a class="site-link" href="{rss/channel/link}">Visit the website →</a>
          </section>

          <section aria-labelledby="recent-items">
            <div class="items-heading">
              <div class="eyebrow">Latest writing</div>
              <h2 id="recent-items">Recent entries</h2>
            </div>
            <ol>
              <xsl:for-each select="rss/channel/item">
                <li>
                  <a href="{link}"><xsl:value-of select="title"/></a>
                  <time><xsl:value-of select="substring(pubDate, 6, 11)"/></time>
                </li>
              </xsl:for-each>
            </ol>
          </section>
        </main>

        <footer>
          <p>The feed remains ordinary RSS underneath this presentation, so it works in standard feed readers.</p>
        </footer>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
