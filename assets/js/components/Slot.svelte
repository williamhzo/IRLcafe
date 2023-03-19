<script>
  export let booking;
  export let available;
  export let selected;
  export let on_slot_click;

  function handle_click() {
    on_slot_click(booking);
  }
</script>

<button
  on:click={handle_click}
  disabled={!available}
  data-available={available.toString()}
  data-selected={selected.toString()}
  class={`border group select-none border-brand ${
    available && !selected ? 'hover:border-gray-500 hover:text-gray-500' : ''
  } rounded-md px-5 py-2 outline-none ring-offset-2 focus-visible:ring-brand focus-visible:ring-2 grid place-items-center duration-150 transition-colors data-[selected=true]:bg-brand data-[selected=true]:text-white data-[available=false]:border-gray-400 data-[available=false]:text-gray-400 data-[available=false]:cursor-not-allowed gap-1`}
>
  <p class="text-center relative font-semibold">
    <slot />
  </p>
</button>
