# JavaSrcipt Code

# Inline for Google analytics
JS_google_analytics = HTML("<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-85196353-2', 'auto');
  ga('send', 'pageview');

</script>")

# Get user language
JS_get_language = HTML("<script>
        var sprache = '';
        if(navigator.browserLanguage){
          sprache = navigator.browserLanguage;
        } else if(navigator.language){
          sprache = navigator.language;
        } else {
          sprache = '';
        }
//document.write(sprache);

var page = window.location.href;
//document.write(page);
         </script>")


JS_test = HTML("<script>
for(var i in lang){
document.write(i + ' ' + lang[i]);
document.write('<br>');
}
         </script>")



# Video
JS_video = HTML("<script>$('#videoLink').click(function() {
                  tabs = $('.tabbable .nav.nav-tabs li')
                 tabs.each(function() {
                 $(this).removeClass('active')
                 })
                 $(tabs[1]).addClass('active')
                 
                 tabsContents = $('.tabbable .tab-content .tab-pane')
                 tabsContents.each(function() {
                 $(this).removeClass('active')
                 })
                 $(tabsContents[1]).addClass('active')
                 
                 $('#summary').trigger('change').trigger('shown');
                 
                 })</script>
                ")