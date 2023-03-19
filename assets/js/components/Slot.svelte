<script>
  export let available;
  export let selected_bookings;
  export let booking;

  let selected = selected_bookings.some(
    (b) => b.date === booking.date && b.slot === booking.slot
  );

  function handleClick() {
    if (selected) {
      selected_bookings = selected_bookings.filter(
        (booking) => booking !== booking
      );
      selected = false;
    } else {
      selected_bookings = [...selected_bookings, booking];
      selected = true;
    }
  }
</script>

<button
  on:click={handleClick}
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
