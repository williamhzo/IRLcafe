<script>
  import Slots from './Slots.svelte';

  export let places;

  let show_slots = false;

  function handleClick() {
    show_slots = !show_slots;
  }
</script>

<ul
  class="first:pl-[10%] scrollbar-none flex w-full last:pr-[10%] snap-x snap-mandatory py-2 items-start gap-2 overflow-x-scroll"
>
  {#each places as place}
    <li
      class="relative p-3 border rounded-base xs:p-4 bg-gray-50/75 sm:p-5 group overflow-hidden border-gray-100 h-full w-[90%] shrink-0 snap-center"
    >
      <button
        on:click={handleClick}
        class="grid grid-rows-[auto,1fr,auto] gap-8 outline-transparent ring-offset-2 focus-visible:ring-brand focus-visible:ring-2"
      >
        <div class="items-items flex justify-between">
          <h3 class="text-xl font-bold md:text-lg">{place.label}</h3>

          <span class="relative flex h-3 w-3 shrink-0 z-20">
            <span
              class="absolute inline-flex h-full w-full animate-ping rounded-full bg-green-400 opacity-75"
            />
            <span
              class="relative inline-flex h-3 w-3 rounded-full bg-green-500"
            />
          </span>
        </div>

        <div class="flex flex-col items-start">
          <p class="prose lowercase text-start">{place.description}</p>

          <small class="text-muted text-base lowercase text-start">
            John and 7 others are meeting there
          </small>
        </div>
        <img
          src="https://images.unsplash.com/photo-1417325384643-aac51acc9e5d?q=75&fm=jpg&w=1080&fit=max"
          class="w-full max-w-full rounded-lg object-cover object-center aspect-video"
          alt={place.label}
        />

        <div class="flex flex-col items-center">
          <p class="text-muted text-center">420m from your location</p>
          <a
            href="https://goo.gl/maps/MB5bAcswpUryWinm9"
            class="text-center text-sm font-normal underline"
          >
            see in google maps
          </a>
        </div>
      </button>

      {#if show_slots}
        <Slots />
      {/if}
    </li>
  {/each}
</ul>
