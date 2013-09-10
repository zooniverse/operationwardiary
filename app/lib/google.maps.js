

function loadScript() {
  window.gmcallback = function(){}
  var script = document.createElement("script");
  script.type = "text/javascript";
  script.src = "http://maps.googleapis.com/maps/api/js?key=AIzaSyB_WfaVGw6NVmWVt4tNG7S7MPzZLF72EmA&sensor=false&callback=gmcallback";
  document.body.appendChild(script);
}

window.onload = loadScript;
