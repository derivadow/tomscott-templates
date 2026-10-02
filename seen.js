(function () {
	var gallery = document.querySelector("[data-seen-gallery]");
	if (!gallery) return;

	var targetHeight = 235;
	var gap = 12;
	var mobile = window.matchMedia("(max-width: 600px)");

	function layout() {
		var items = Array.prototype.slice.call(gallery.querySelectorAll(".seen-item"));

		if (mobile.matches) {
			items.forEach(function (item) {
				item.style.width = "";
				item.style.height = "";
			});
			return;
		}

		var available = gallery.clientWidth;
		var row = [];
		var ratioSum = 0;

		function setRow(rowItems, sum, justify) {
			if (!rowItems.length) return;
			var gaps = gap * (rowItems.length - 1);
			var height = justify ? (available - gaps) / sum : targetHeight;

			rowItems.forEach(function (item) {
				var ratio = Number(item.dataset.width) / Number(item.dataset.height);
				item.style.width = (height * ratio) + "px";
				item.style.height = height + "px";
			});
		}

		items.forEach(function (item) {
			var ratio = Number(item.dataset.width) / Number(item.dataset.height);
			if (!isFinite(ratio) || ratio <= 0) return;

			row.push(item);
			ratioSum += ratio;

			var projected = ratioSum * targetHeight + gap * (row.length - 1);
			if (projected >= available) {
				setRow(row, ratioSum, true);
				row = [];
				ratioSum = 0;
			}
		});

		setRow(row, ratioSum, false);
	}

	layout();
	window.addEventListener("resize", layout);
}());
