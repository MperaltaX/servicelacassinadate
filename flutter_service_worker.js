'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"main.dart.js": "0ed430194f15cc104f7f424fae97a2f9",
"canvaskit/skwasm.wasm": "f767200511478d7f7052f2b536d82875",
"canvaskit/chromium/canvaskit.js": "c5ff0f8767a7ea0962b15d1f1832002d",
"canvaskit/chromium/canvaskit.wasm": "c6b1144d5baffbdd9482ee820dbd7dc9",
"canvaskit/skwasm.js": "3dbd05be6db4a4154ce733ff194dcae7",
"canvaskit/canvaskit.js": "3e7c7e90ff8e206f4023c12e31b0d058",
"canvaskit/skwasm.worker.js": "23be0fdafa5ddef67734292a576f8fe3",
"canvaskit/canvaskit.wasm": "296ba26fdb37b50c239d4ead66144d01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "32d5f02f3b31c83e9256d1998d5536a0",
"manifest.json": "e78a9b1edf6de2c469a328a299e4bacf",
"assets/AssetManifest.json": "a60e031ba6a2755e4f127e891fd54aef",
"assets/shaders/ink_sparkle.frag": "57f2f020e63be0dd85efafc7b7b25d80",
"assets/assets/imgScreen.png": "bf0b414b71113d9fb9a8c4c722b15b41",
"assets/assets/splash.png": "e2b88c3880abc92b9e26629855c3c093",
"assets/assets/splash.gif": "eb15f992836fb67b0d70e0b0fa19dca3",
"assets/assets/imgScreen3.png": "ffcef7a778cebf2aeee2c6903b7e08e4",
"assets/assets/imgScreen2.png": "6fa37dd2dce7d7f815ed37193f9932a0",
"assets/assets/imgScreen1.png": "c0f23dfb02740ff38d4b159de2d72db2",
"assets/assets/imgScreen4.png": "25b0bc12dde20ee39c57f6284497e74b",
"assets/AssetManifest.bin": "3b95225d062890993d9d7169368717fd",
"assets/fonts/MaterialIcons-Regular.otf": "90e77cfdc31566485604d908354e0777",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "b6fc1bf15412b273b8aff03496f22cff",
"index.html": "514853d792d34f826703a47b1b78cfe2",
"/": "514853d792d34f826703a47b1b78cfe2",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"splash/style.css": "3e8699dd65a865ff991ec5b47a93643d",
"splash/img/light-3x.png": "f86db507ab8f4bfea8d2f3ab8ac22f17",
"splash/img/dark-1x.png": "2db64f791a0e55607e03ce69b918ce35",
"splash/img/dark-2x.png": "05e76469d8e193808d8bf41b75cad489",
"splash/img/light-2x.png": "05e76469d8e193808d8bf41b75cad489",
"splash/img/dark-4x.png": "8bbb6ffcac2a07903da3d66896e68c80",
"splash/img/light-4x.png": "8bbb6ffcac2a07903da3d66896e68c80",
"splash/img/dark-3x.png": "f86db507ab8f4bfea8d2f3ab8ac22f17",
"splash/img/light-1x.png": "2db64f791a0e55607e03ce69b918ce35"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
