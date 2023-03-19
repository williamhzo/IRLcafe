<script>
  import { fly } from 'svelte/transition';
  import addDays from 'date-fns/addDays';
  import groupBy from 'lodash/groupBy';
  import uniq from 'lodash/uniq';

  import Slot from './Slot.svelte';
  import { formatDate } from '../utils/dates.utils';

  export let place;
  export let request;

  const today_date = new Date();
  const tomorrow_date = addDays(today_date, 1);
  const today = today_date.toISOString().split('T')[0];
  const tomorrow = tomorrow_date.toISOString().split('T')[0];

  const bookings_labels = [
    { date: today, slot: 'morning' },
    { date: today, slot: 'lunch' },
    { date: today, slot: 'afternoon' },
    { date: today, slot: 'afterwork' },
    { date: tomorrow, slot: 'morning' },
    { date: tomorrow, slot: 'lunch' },
    { date: tomorrow, slot: 'afternoon' },
    { date: tomorrow, slot: 'afterwork' },
  ];

  const today_bookings = bookings_labels.filter(({ date }) => date === today);
  const tomorrow_bookings = bookings_labels.filter(
    ({ date }) => date === tomorrow
  );

  const bookings_from_server = place.bookings;

  let selected_bookings = bookings_from_server.filter((booking) =>
    [today, tomorrow].includes(booking.date)
  );

  function on_slot_click(booking) {
    if (is_booking_selected(selected_bookings, booking)) {
      selected_bookings = selected_bookings.filter(
        (b) => !is_same_booking(booking, b)
      );
    } else {
      selected_bookings = [...selected_bookings, booking];
    }
  }

  function is_booking_selected(selected_bookings, booking) {
    return selected_bookings.some((b) => is_same_booking(booking, b));
  }

  function is_same_booking(booking_1, booking_2) {
    return (
      booking_1.date === booking_2.date && booking_1.slot === booking_2.slot
    );
  }

  function get_booked_volume(bookings, booking) {
    return bookings.filter((b) => is_same_booking(booking, b)).length;
  }

  $: console.log('selected_bookings', selected_bookings);

  let booking_success = false;

  function submit_bookings() {
    if (selected_bookings.length > 0) {
      request(
        'submit_bookings',
        { bookings: format_bookings(selected_bookings), place_id: place.id },
        ({ bookings }) => {
          // FIXME: les bookings sont tous `null`
          console.log('bookings', bookings);
          booking_success = true;
        }
      );
    }
  }

  function format_bookings(bookings) {
    const format_bookings = groupBy(bookings, (b) => b.date);

    const bookings_array = Object.entries(format_bookings)
      .map(([date, bookings]) => [date, bookings.map((b) => b.slot)])
      .map(([date, slots]) => [date, uniq(slots)]);

    return Object.fromEntries(bookings_array);
  }

  function is_today_slot_available(booking) {
    const hours = new Date().getHours();

    switch (booking.slot) {
      case 'morning':
        return hours < 12;
      case 'lunch':
        return hours < 14;
      case 'afternoon':
        return hours < 17;
      case 'afterwork':
        return hours < 21;
      default:
        return true;
    }
  }
</script>

<!-- class="flex rounded-base flex-col gap-8 items-start h-full p-5 absolute inset-0 z-10 bg-background/90 backdrop-blur-lg" -->
<section class="flex rounded-base flex-col gap-8 items-start">
  <div class="flex flex-col items-start">
    <h2 class="text-xl font-bold">when do you feel like going?</h2>
    <p class="text-muted text-left">
      people are more likely to join if they know they're not alone 🤝
    </p>
  </div>

  <div class="w-full">
    <div class="flex items-baseline justify-between">
      <p class="font-semibold text-muted">today</p>

      <small class="text-muted lowercase">{formatDate(today_date)}</small>
    </div>

    <div class="grid grid-cols-2 gap-2 mt-2">
      {#each today_bookings as booking}
        <Slot
          {booking}
          available={is_today_slot_available(booking)}
          selected={is_booking_selected(selected_bookings, booking)}
          volume_booked={get_booked_volume(bookings_from_server, booking)}
          {on_slot_click}
        >
          {booking.slot}
        </Slot>
      {/each}
    </div>
  </div>

  <div class="w-full">
    <div class="flex items-center justify-between">
      <p class="font-semibold text-muted">tomorrow</p>

      <small class="text-muted lowercase">{formatDate(tomorrow_date)}</small>
    </div>

    <div class="grid grid-cols-2 gap-2 mt-2">
      {#each tomorrow_bookings as booking}
        <Slot
          {booking}
          available={true}
          selected={is_booking_selected(selected_bookings, booking)}
          volume_booked={get_booked_volume(bookings_from_server, booking)}
          {on_slot_click}
        >
          {booking.slot}
        </Slot>
      {/each}
    </div>
  </div>

  <button
    on:click={submit_bookings}
    disabled={selected_bookings.length === 0}
    class="self-center touch-none select-none duration-150 transition-colors rounded-lg bg-brand text-white px-8 py-2 hover:bg-brand-surface-hover outline-transparent focus-visible:ring-2 ring-offset-2 focus-visible:ring-brand disabled:opacity-60"
  >
    go
  </button>

  {#if booking_success}
    <section
      in:fly={{ y: 25, duration: 300 }}
      out:fly={{ y: -25, duration: 300 }}
      class="absolute shadow-sm flex flex-col items-center top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 self-center bg-background/75 rounded-base backdrop-blur-md p-5 gap-5 border border-gray-100 w-max max-w-full"
    >
      <svg
        width="15"
        height="15"
        viewBox="0 0 15 15"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
        class="w-8 h-8 text-muted"
        ><path
          d="M7.49991 0.877045C3.84222 0.877045 0.877075 3.84219 0.877075 7.49988C0.877075 11.1575 3.84222 14.1227 7.49991 14.1227C11.1576 14.1227 14.1227 11.1575 14.1227 7.49988C14.1227 3.84219 11.1576 0.877045 7.49991 0.877045ZM1.82708 7.49988C1.82708 4.36686 4.36689 1.82704 7.49991 1.82704C10.6329 1.82704 13.1727 4.36686 13.1727 7.49988C13.1727 10.6329 10.6329 13.1727 7.49991 13.1727C4.36689 13.1727 1.82708 10.6329 1.82708 7.49988ZM10.1589 5.53774C10.3178 5.31191 10.2636 5.00001 10.0378 4.84109C9.81194 4.68217 9.50004 4.73642 9.34112 4.96225L6.51977 8.97154L5.35681 7.78706C5.16334 7.59002 4.84677 7.58711 4.64973 7.78058C4.45268 7.97404 4.44978 8.29061 4.64325 8.48765L6.22658 10.1003C6.33054 10.2062 6.47617 10.2604 6.62407 10.2483C6.77197 10.2363 6.90686 10.1591 6.99226 10.0377L10.1589 5.53774Z"
          fill="currentColor"
          fill-rule="evenodd"
          clip-rule="evenodd"
        /></svg
      >
      <div class="flex flex-col items-center">
        <p class="text-center text-lg font-bold">nice, see you tonight!</p>

        <small class="text-muted"
          >tell your coffee-buddies to come over 👨‍💻☕</small
        >
      </div>
    </section>
  {/if}
</section>
