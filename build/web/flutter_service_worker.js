'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"favicon.png": "4327d8ef927c3147da2beb14cd37d4bf",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"sqlite3.wasm": "c78938b24bbe18f20172a341bbd5fc92",
"sqflite_sw.js": "be7f48e552afb0d1a735b966d1565365",
"version.json": "142bc4140d0c66e9c68e46d402fbe9e7",
"main.dart.js": "a12ce38a3014ea7977ff1e1a6dd27e9d",
"logo.png": "485b646c6a3011a901799de526d251cd",
"manifest.json": "53144a106f807996d04c85550520a0dc",
"icons/Icon-maskable-192.png": "0964ff4d3844627256a2298b963312c1",
"icons/Icon-192.png": "0964ff4d3844627256a2298b963312c1",
"icons/Icon-512.png": "ec1ac7856bdfd762376c3922b4e70d08",
"icons/Icon-maskable-512.png": "ec1ac7856bdfd762376c3922b4e70d08",
"assets/AssetManifest.json": "bd3e7ddd441eee9301c50e8d05c8b2c3",
"assets/AssetManifest.bin.json": "a2342bbeb11563a00785cfc00bc7738a",
"assets/fonts/MaterialIcons-Regular.otf": "757ec76e9ff11d2999a57a0c2f52cf7d",
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
"assets/assets/mnstr_parts/head_2-back.png": "2b60c8894c214d2d4c99cc8f1905fc70",
"assets/assets/mnstr_parts/arms_two.png": "6768fd48485c137b9b345c152cf0d934",
"assets/assets/mnstr_parts/head_1-back.png": "959b5a971bedb76aeb79d7067891872a",
"assets/assets/mnstr_parts/horns_short.png": "8648812a9b2024bdb9def014c71fe887",
"assets/assets/mnstr_parts/legs_short.png": "6464c7bf41fd74698e06ff5fcc3a9884",
"assets/assets/mnstr_parts/head_2.png": "f42a4b43cbcf2ca4ae0c35b23f23a499",
"assets/assets/mnstr_parts/horns_spiraled.png": "2a614ef7f8eebf6e5ce6b66675921bf6",
"assets/assets/mnstr_parts/legs_long.png": "7391286cf137416b1ca3134cf912a024",
"assets/assets/mnstr_parts/tail_long.png": "2afbc7aa358bb5a720bd15ea1070914c",
"assets/assets/mnstr_parts/horns_striped.png": "c73f872a20f8ed37641b24ee873e4f45",
"assets/assets/mnstr_parts/arms_four.png": "4f4115baf5edb68851930a9fd4a08d8c",
"assets/assets/mnstr_parts/tail_stripes.png": "4df0f1a7d74ee81b5fc7407194640044",
"assets/assets/mnstr_parts/head_1.png": "6204bedfb87e6b30f1eadf9248a47425",
"assets/assets/mnstr_parts/tail_twins.png": "f0d88b4418daf76c4a64c0724d743883",
"assets/assets/mnstr_parts/body_base.png": "15fff44cef72510e7edc9bfc806a1c2f",
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
"assets/FontManifest.json": "bf5cf13237052358e7c9fd4d3c0ad415",
"assets/AssetManifest.bin": "673fe04f4a7661a40f1a5c98bdf86b98",
"assets/NOTICES": "220b988d8d400c339e9bdbbcce1acadf",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/wiredash/lib/assets/fonts/Inter-Bold.ttf": "cef517a165e8157d9f14a0911190948d",
"assets/packages/wiredash/lib/assets/fonts/Inter-Regular.ttf": "eba360005eef21ac6807e45dc8422042",
"assets/packages/wiredash/lib/assets/fonts/Wirecons.ttf": "39dff657dd43bfb7ab7e25406d4baab7",
"assets/packages/wiredash/lib/assets/fonts/Inter-SemiBold.ttf": "3e87064b7567bef4ecd2ba977ce028bc",
"assets/packages/wiredash/assets/images/logo_white.png": "d51118529c8b6f919c485cd81e9a840e",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "e949713f8bb3a755d44ac95a5a424214",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "8bea1e24b595b364abcc7d217156de6c",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "7c9b70097070338f4cbfd18227c9c61b",
"index.html": "076cc923a76efa24c0fc093c7faf61ff",
"/": "076cc923a76efa24c0fc093c7faf61ff",
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
"flutter_bootstrap.js": "582e56e0ba3e34cfa4e7f951a9bda205"};
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
