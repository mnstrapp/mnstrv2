'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"favicon.png": "4327d8ef927c3147da2beb14cd37d4bf",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"version.json": "89f4cd26ee284c0183f7efe0f3b93df5",
"main.dart.js": "a661187ff2b55c52a9350a1f179ad068",
"logo.png": "485b646c6a3011a901799de526d251cd",
"main.dart.mjs": "d0e909a0384344255eaf9f54bec35336",
"main.dart.wasm": "aec24434ddd6477534582b9536cf9d41",
"manifest.json": "53144a106f807996d04c85550520a0dc",
"icons/Icon-maskable-192.png": "0964ff4d3844627256a2298b963312c1",
"icons/Icon-192.png": "0964ff4d3844627256a2298b963312c1",
"icons/Icon-512.png": "ec1ac7856bdfd762376c3922b4e70d08",
"icons/Icon-maskable-512.png": "ec1ac7856bdfd762376c3922b4e70d08",
"assets/AssetManifest.json": "b04dbff2c8717f9a0f7e9396e838a458",
"assets/AssetManifest.bin.json": "874a9d60a82543255f4b08536fd8cb79",
"assets/fonts/MaterialIcons-Regular.otf": "9e33d73659d4da20a46f3d32b446d3d8",
"assets/assets/audio/collect-2.mp3": "09f650f328fc19284f4fd1c67e337694",
"assets/assets/audio/accept-2.mp3": "26dd5f489f30758124a07d5d4b1996eb",
"assets/assets/audio/mnstr-game-music.m4a": "9a51c262b42dfc9af314a4ad649bf882",
"assets/assets/logo.png": "485b646c6a3011a901799de526d251cd",
"assets/assets/fonts/Roboto-Light.ttf": "25e374a16a818685911e36bee59a6ee4",
"assets/assets/fonts/Roboto-Black.ttf": "dc44e38f98466ebcd6c013be9016fa1f",
"assets/assets/fonts/Roboto-BoldItalic.ttf": "dc10ada6fd67b557d811d9a6d031c4de",
"assets/assets/fonts/Roboto-Regular.ttf": "303c6d9e16168364d3bc5b7f766cfff4",
"assets/assets/fonts/Roboto-Medium.ttf": "7d752fb726f5ece291e2e522fcecf86d",
"assets/assets/fonts/Silkscreen-Regular.ttf": "25fe3c5b81c19abcba746ad98e241919",
"assets/assets/fonts/Roboto-Bold.ttf": "dd5415b95e675853c6ccdceba7324ce7",
"assets/assets/fonts/Roboto-Italic.ttf": "1fc3ee9d387437d060344e57a179e3dc",
"assets/assets/fonts/Roboto-LightItalic.ttf": "00b6f1f0c053c61b8048a6dbbabecaa2",
"assets/assets/fonts/Silkscreen-Bold.ttf": "86ca8253751fb78de48b68a11392d2a4",
"assets/assets/fonts/Roboto-Thin.ttf": "1e6f2d32ab9876b49936181f9c0b8725",
"assets/assets/fonts/Roboto-ThinItalic.ttf": "dca165220aefe216510c6de8ae9578ff",
"assets/assets/fonts/Roboto-BlackItalic.ttf": "792016eae54d22079ccf6f0760938b0a",
"assets/assets/fonts/Roboto-MediumItalic.ttf": "918982b4cec9e30df58aca1e12cf6445",
"assets/assets/mnstr_parts/arms_two.png": "6289ebdb27d117d15d14394c599d0396",
"assets/assets/mnstr_parts/horns_short.png": "b00f544351fce16244890d1fbb4718df",
"assets/assets/mnstr_parts/legs_short.png": "23a1509a118231680531181d6f1efcdb",
"assets/assets/mnstr_parts/head_2.png": "098f0d65c43cbe8a9106f7cee75b7b4c",
"assets/assets/mnstr_parts/horns_spiraled.png": "1b066f6ed2242b245d43699f3e86485a",
"assets/assets/mnstr_parts/legs_long.png": "0bb1c40bfee6dfa5b5d84f6e22df435b",
"assets/assets/mnstr_parts/tail_long.png": "6383d2b13c10149de84e6ab8de43c91d",
"assets/assets/mnstr_parts/horns_striped.png": "2ee4eac284fe2494bd027bf390c14c39",
"assets/assets/mnstr_parts/arms_four.png": "16017102e6a9c75560b8a9e9ce6d33cc",
"assets/assets/mnstr_parts/tail_stripes.png": "77e26172ed37bdbdb6d1e40f4546a54c",
"assets/assets/mnstr_parts/head_1.png": "6d2b7b4b1bf4bfb37e758b2d431f741a",
"assets/assets/mnstr_parts/tail_twins.png": "468fc715ceba7cfb5d295f95059aacc6",
"assets/assets/mnstr_parts/body_base.png": "24fa8f4b03dd5530c3ac4c719cad1b22",
"assets/assets/stars/star_5.png": "f413cc0b56a4b6be15f9cb1f816ed0f2",
"assets/assets/stars/star_4.png": "bdb1a1437a87691f0e032f31f6766377",
"assets/assets/stars/star_6.png": "b9e5c4f64fdda921f4edf285458f5bca",
"assets/assets/stars/star_3.png": "f109c5b0ba49928bad7087ab0ea05fc4",
"assets/assets/stars/star_2.png": "95191d1d583a00ebdcbc888d43be2d16",
"assets/assets/stars/star_1.png": "674f2d740949262a8cf5485e03b45d7e",
"assets/assets/loading_figure.png": "488e962d72e5ece821a2dbfba440391f",
"assets/assets/items/health_potion.png": "84839c00b5e9d1411b1f08ca659baf4a",
"assets/assets/items/empty_bottle.png": "bd3c6759fd21a3c27303c32c06c50e34",
"assets/assets/items/stealth_potion.png": "c7ee7b6fa8b80a36d066547f655d0779",
"assets/assets/items/coin.png": "7317addfa25c828dde497446ac41521e",
"assets/assets/items/magic_potion.png": "d34dcc8f71244b21f3e9fbeddc421a54",
"assets/assets/items/attack_potion.png": "72ec8ea1068db60e029cb10c57632eb1",
"assets/FontManifest.json": "036d37b43fedc34e3a9edbdff04b0b2c",
"assets/AssetManifest.bin": "5901620700f43485383a58c06ceffd54",
"assets/NOTICES": "cd815bb1972517fb42a2e3685504d28a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"index.html": "fb8d1006e424875285f6423e61977ef6",
"/": "fb8d1006e424875285f6423e61977ef6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"flutter_bootstrap.js": "fade666ca04676a497afd73a28def8b2"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
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
