{{{app_js}}}

// This script is embedded in the footer of every page

// Move paragraph-level source links into the reading margin when space permits.
// The authored link remains inline by default and is restored there at narrower widths.
(function () {
	// Match the paragraph-citation breakpoint in style.css.
	var query = window.matchMedia("(min-width: 76rem)");

	function terminalCitation(paragraph) {
		if (!paragraph || paragraph.matches(":has(img)")) return null;

		var links = paragraph.querySelectorAll(":scope > a");
		if (!links.length) return null;

		var link = links[links.length - 1];
		// A source title is part of the site's citation authoring convention.
		// Ordinary prose links and download actions must stay in the sentence.
		if (!(link.getAttribute("title") || "").trim() || link.hasAttribute("download")) return null;

		var before = "";
		for (var sibling = paragraph.firstChild; sibling && sibling !== link; sibling = sibling.nextSibling) {
			before += sibling.textContent;
		}

		var after = "";
		for (var node = link.nextSibling; node; node = node.nextSibling) {
			if (node.nodeType === Node.TEXT_NODE) after += node.textContent;
			else if (node.nodeType === Node.ELEMENT_NODE) return null;
		}

		// A titled source must follow complete prose, either in parentheses
		// or after sentence-ending punctuation. A terminal link alone is not enough.
		if (!/^[\s\)\]\.,;:!?]*$/.test(after)) return null;
		var parenthetical = /\($/.test(before) && /^\)/.test(after);
		var afterSentence = /[.!?\u2026]\s*$/.test(before);
		if (!before.replace(/\($/, "").trim() || (!parenthetical && !afterSentence)) return null;

		var href = link.getAttribute("href") || "";
		if (!/^https?:\/\//i.test(href)) return null;

		return link;
	}

	function restore(paragraph) {
		var citation = paragraph.querySelector(":scope > .marginal-citation");
		if (!citation) return;

		var link = citation.querySelector("a");
		var marker = paragraph.querySelector(":scope > .citation-marker");
		if (link && marker) {
			var prefix = marker.dataset.prefix || "";
			var suffix = marker.dataset.suffix || "";
			var fragment = document.createDocumentFragment();
			if (prefix) fragment.appendChild(document.createTextNode(prefix));
			fragment.appendChild(link);
			if (suffix) fragment.appendChild(document.createTextNode(suffix));
			marker.replaceWith(fragment);
		}
		citation.remove();
		paragraph.classList.remove("has-marginal-citation");
	}

	function enhance(paragraph) {
		if (paragraph.querySelector(":scope > .marginal-citation")) return;
		var link = terminalCitation(paragraph);
		if (!link) return;

		var previous = link.previousSibling;
		var next = link.nextSibling;
		var prefix = "";
		var suffix = "";

		// Parentheses are useful inline but become visual debris when the
		// citation moves to the margin. Preserve them on the hidden marker
		// so the authored form can be restored exactly at narrower widths.
		if (previous && previous.nodeType === Node.TEXT_NODE && /\($/.test(previous.textContent)) {
			previous.textContent = previous.textContent.slice(0, -1);
			prefix = "(";
		}
		if (next && next.nodeType === Node.TEXT_NODE && /^\)/.test(next.textContent)) {
			next.textContent = next.textContent.slice(1);
			suffix = ")";
		}

		var marker = document.createElement("span");
		marker.className = "citation-marker";
		marker.hidden = true;
		marker.dataset.prefix = prefix;
		marker.dataset.suffix = suffix;
		link.replaceWith(marker);

		var citation = document.createElement("span");
		citation.className = "marginal-citation";
		citation.setAttribute("role", "note");

		var source = document.createElement("span");
		source.className = "marginal-citation-source";
		source.appendChild(link);
		citation.appendChild(source);

		var title = link.getAttribute("title");
		if (title) {
			var detail = document.createElement("span");
			detail.className = "marginal-citation-title";
			detail.textContent = title;
			citation.appendChild(detail);
		}

		paragraph.appendChild(citation);
		paragraph.classList.add("has-marginal-citation");
	}

	function update() {
		document.querySelectorAll(".entry > p").forEach(function (paragraph) {
			if (query.matches) enhance(paragraph);
			else restore(paragraph);
		});
	}

	update();
	if (query.addEventListener) query.addEventListener("change", update);
	else query.addListener(update);
}());
