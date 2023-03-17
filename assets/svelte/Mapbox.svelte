<script>
  import { onMount } from 'svelte';
  import mapboxgl from 'mapbox-gl';
  import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

  const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1Ijoid2lsbGlhbS1oem8iLCJhIjoiY2xmYnByZHEwMGZxMzNvbXZmdDB3bTlyZyJ9.nz4hALRlNGSKV8N-nySK2g';

  onMount(() => {
    mapboxgl.accessToken = MAPBOX_ACCESS_TOKEN;

    const map = new mapboxgl.Map({
      container: 'map-container',
      style: 'mapbox://styles/mapbox/streets-v12',
      center: [12.65147, 55.608166],
      zoom: 12,
    });

    // // Add a marker to the map
    const marker = new mapboxgl.Marker()
      .setLngLat([-122.4194, 37.7749])
      .addTo(map);

    map.addMarker(marker);

    // Add a geocoder control to the map
    const geocoder = new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl,
    });

    map.addControl(geocoder);
  });
</script>

<div id="map-container" class="w-full h-screen" />
