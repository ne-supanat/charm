'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "888483df48293866f9f41d3d9274a779",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "273c167f4d839c806b6dae68a8e0e1c3",
"index.html": "9584f0cc41065548e8bb046f15b76d5e",
"/": "9584f0cc41065548e8bb046f15b76d5e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "ed81d0be67d4b87c71c0e31cebcee43e",
"assets/assets/icons/info.png": "d47fedf3ff878ab7a3fec4af302c57e1",
"assets/assets/icons/play.png": "6d61563a1b3c607d22b7df4f9a2f95ff",
"assets/assets/icons/music.png": "b33971e961e3c025da337bdc6b7bd5c8",
"assets/assets/icons/image.png": "8d4f03a67d129e00fdd907671b1de12c",
"assets/assets/icons/star.png": "8129aa7b2c889ecf8260596738515b1e",
"assets/assets/icons/hidden.png": "38b301c6c80e6a114fee867a1ccdbd88",
"assets/assets/images/object_sakura.png": "2e0dc46678fc24acb57754d88fd33e8c",
"assets/assets/images/bg_city_mobile.jpg": "67214f97ace670a31c474323a6a22f18",
"assets/assets/images/item_clover.png": "c85cd72642887f75180e4139e3deb22f",
"assets/assets/images/dark_noise.jpg": "56680e4359be90b25ae68f633fac8db5",
"assets/assets/images/bg_night_mobile.jpg": "c31c7678b7aec8ec04071591f31089a0",
"assets/assets/images/star_bottom.png": "0c7610a8bf05aa7a001f70ee8de70747",
"assets/assets/images/bg_forest_web.jpg": "e9f8be12d4697396ef31bf7b08b11262",
"assets/assets/images/star_top.png": "1ea782d436d53c6735e53abcddeac771",
"assets/assets/images/item_peony.png": "070dae7d2b725e26860e8efc1bb910ae",
"assets/assets/images/bg_beach_mobile.jpg": "61c32174da9efb9b70a09ba8396577d5",
"assets/assets/images/item_pair_of_cranes.png": "10a4c89b44245974a10c3003d48092f1",
"assets/assets/images/bg_forest_mobile.jpg": "74d18d420d76a06720fb26f37e07107f",
"assets/assets/images/item_horseshoe.png": "a9ad56a3b016001595fe2f8fad3eed3b",
"assets/assets/images/bg_beach_web.jpg": "d9061f52a1f0f4d4510edb25b749e9b0",
"assets/assets/images/bg_city_web.jpg": "ba18df2a09ad1064ab47a4f61973d842",
"assets/assets/images/bg_night_web.jpg": "eb613c8458bb38771e369779c682d938",
"assets/assets/images/item_butterfly.png": "b9fbc263cc2477a23dd92950c058393f",
"assets/assets/musics/On%2520The%2520Flip%2520-%2520The%2520Grey%2520Room%2520_%2520Density%2520&%2520Time.mp3": "5494530b7f0f9f470b9bb76b6b60cdcd",
"assets/assets/musics/Underwater%2520Exploration%2520-%2520Godmode.mp3": "aaae7fee93bd10b16af1e0321fa931ac",
"assets/assets/musics/Moonlight%2520Magic%2520-%2520Asher%2520Fulero.mp3": "8cef916b3638df7a5d822656feb09b94",
"assets/assets/musics/make%2520the%2520visible%2520invisible%2520-%2520Alge.mp3": "3c3e0c1bb5451b45ef5b0854725767c0",
"assets/assets/musics/The%2520Palace%2520Gardens%2520-%2520Asher%2520Fulero.mp3": "68d77052d5c5bc6524ab42e83929b933",
"assets/assets/jsons/backgrounds.json": "44bab213cd75bbde9e281f89a93e1622",
"assets/assets/jsons/musics.json": "4c76e1ba5ab0ad4a122266ff499f60b8",
"assets/assets/jsons/items.json": "717bef120c4710fd7b3a118324ea4497",
"assets/fonts/MaterialIcons-Regular.otf": "5a2cf4152496d9a90af76cb39c84827a",
"assets/NOTICES": "fd9674769a086a27c3da5587dbad396d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "c52fc104efa93bc90aa5fa04eb07efb4",
"assets/AssetManifest.json": "b685049f7bf4827fa2f20fe810e55189",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "3a435b2c1cfe546a5534595b3b01a17e",
"version.json": "104f406bf09842e81c7cc00f39c5d923",
"main.dart.js": "fe66d3e761e6252bd1f9f56ed34e6587"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
