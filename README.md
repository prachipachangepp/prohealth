# prohealth

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

add following script to index.html before deployment inside body tag

 <script>
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', function () {
        xmlhttp = new XMLHttpRequest();
        xmlhttp.open("GET", './version.json', true);
        xmlhttp.onload = function () {
          if (xmlhttp.status == 200) {
            var version = xmlhttp.responseText.split(',')[1];
            var currentVersion = window.localStorage.getItem('version');
            console.log('currentVersion is ' + currentVersion);
            console.log('version is ' + version);
            if (currentVersion && currentVersion != version) {
              console.log('clearing cache');
              caches.delete('flutter-app-manifest');
              caches.delete('flutter-temp-cache');
              caches.delete('flutter-app-cache');
            }
            window.localStorage.setItem('version', version);
          }
        };
        xmlhttp.send();
      });
    }
  </script>


ex. 
 <body>
  <script>
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', function () {
        xmlhttp = new XMLHttpRequest();
        xmlhttp.open("GET", './version.json', true);
        xmlhttp.onload = function () {
          if (xmlhttp.status == 200) {
            var version = xmlhttp.responseText.split(',')[1];
            var currentVersion = window.localStorage.getItem('version');
            console.log('currentVersion is ' + currentVersion);
            console.log('version is ' + version);
            if (currentVersion && currentVersion != version) {
              console.log('clearing cache');
              caches.delete('flutter-app-manifest');
              caches.delete('flutter-temp-cache');
              caches.delete('flutter-app-cache');
            }
            window.localStorage.setItem('version', version);
          }
        };
        xmlhttp.send();
      });
    }
  </script>
  <script src="flutter_bootstrap.js" async></script>
</body>


