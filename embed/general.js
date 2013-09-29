// Device detection
function iTD() {
	var el = document.createElement('div');
	el.setAttribute('ongesturestart', 'return;');
	return (typeof el.ongesturestart == "function" || (/android/gi).test(navigator.appVersion))?((navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/mobile/i))?2:1):false;
}
var iTDstore = iTD();
var ev = {
	c: iTDstore?"touchend":"click",
	m: iTDstore?"touchmove":"mousemove",
	d: iTDstore?"touchstart":"mousedown"
};


$(function() {
	
});