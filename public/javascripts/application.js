var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-12479930-4']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

var uservoiceOptions = {
  /* required */
  key: 'majorleaguepong',
  host: 'majorleaguepong.uservoice.com', 
  forum: '87407',
  showTab: true,  
  /* optional */
  alignment: 'left',
  background_color:'#13365c', 
  text_color: 'white',
  hover_color: '#fedc00',
  lang: 'en'
};

function _loadUserVoice() {
  var s = document.createElement('script');
  s.setAttribute('type', 'text/javascript');
  s.setAttribute('src', ("https:" == document.location.protocol ? "https://" : "http://") + "cdn.uservoice.com/javascripts/widgets/tab.js");
  document.getElementsByTagName('head')[0].appendChild(s);
}
_loadSuper = window.onload;
window.onload = (typeof window.onload != 'function') ? _loadUserVoice : function() { _loadSuper(); _loadUserVoice(); };

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $("table tbody").append(content.replace(regexp, new_id));
  var inputs = $(".sortable tbody input[type='text']");
  var last_round_number = parseInt(inputs.eq(inputs.length - 2).val());
  if (isNaN(last_round_number)) {
    inputs.last().attr("value", 1);
  } else {
    inputs.last().attr("value", last_round_number + 1);
  }
}

//$(document).ready(function() {
//});
