<script>
  import PlaceCard from './PlaceCard.svelte';

  export let request;

  export let places;
  $: console.log('places', places);

  let hide_slots = true;

  function handle_scroll() {
    hide_slots = true;
  }
</script>

<ul
  on:scroll={handle_scroll}
  class="first:pl-[10%] scrollbar-none relative flex w-full last:pr-[10%] snap-x snap-mandatory py-2 items-start gap-2 overflow-x-scroll"
>
  {#each places as place}
    <PlaceCard bind:hide_slots {place} {request} />
  {/each}

  <!-- TODO: gradient on side -->
  <!-- <div class="absolute " /> -->
</ul>
