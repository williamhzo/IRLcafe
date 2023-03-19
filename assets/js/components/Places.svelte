<script>
  import PlaceCard from './PlaceCard.svelte';

  export let places;
  export let request;

  let hide_slots = true;

  function handle_scroll() {
    hide_slots = true;
  }
</script>

<ul
  on:scroll={handle_scroll}
  class="first:pl-[5%] scrollbar-none flex w-full last:pr-[5%] snap-x snap-mandatory py-2 items-start gap-2 overflow-x-scroll"
>
  {#each places as place}
    <PlaceCard bind:hide_slots {place} {request} />
  {/each}
</ul>
