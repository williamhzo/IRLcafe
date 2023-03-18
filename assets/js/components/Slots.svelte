<script>
  import Slot from './Slot.svelte';
  import { formatDate } from '../utils/dates.utils';

  let selected_bookings = [];

  export let request;

  const today = new Date();
  const tomorrow = new Date(today);
  tomorrow.setDate(tomorrow.getDate() + 1);

  const hours = today.getHours();
  const bookings = [
    { date: today, slot: 'morning', available: hours < 12 },
    { date: today, slot: 'lunch', available: hours < 14 },
    { date: today, slot: 'afternoon', available: hours < 17 },
    { date: today, slot: 'afterwork', available: hours < 21 },
    { date: tomorrow, slot: 'morning', available: true },
    { date: tomorrow, slot: 'lunch', available: true },
    { date: tomorrow, slot: 'afternoon', available: true },
    { date: tomorrow, slot: 'afterwork', available: true },
  ];

  const today_bookings = bookings.filter(({ date }) => date === today);
  const tomorrow_bookings = bookings.filter(({ date }) => date === tomorrow);

  const submit_bookings = () => {
    console.log();
    request('submit_bookings', { slots: selected_bookings }, () => {});
  };
</script>

<section class="bg-background flex flex-col gap-8 items-center p-5 pb-72">
  <div>
    <h2 class="text-lg font-bold">when do you feel like going?</h2>
    <p class="text-muted">
      people are more likely to join if they know they're not alone 🤝
    </p>
  </div>

  <div class="w-full">
    <div class="flex items-baseline justify-between">
      <p>today</p>

      <small class="text-muted lowercase">{formatDate(today)}</small>
    </div>
    <div class="grid grid-cols-2 gap-2 mt-2">
      {#each today_bookings as booking}
        <Slot bind:selected_bookings available={booking.available} {booking}
          >{booking.slot}</Slot
        >
      {/each}
    </div>
  </div>

  <div class="w-full">
    <div class="flex items-center justify-between">
      <p>tomorrow</p>

      <small class="text-muted lowercase">{formatDate(tomorrow)}</small>
    </div>
    <div class="grid grid-cols-2 gap-2 mt-2">
      {#each tomorrow_bookings as booking}
        <Slot bind:selected_bookings available={booking.available} {booking}
          >{booking.slot}</Slot
        >
      {/each}
    </div>
  </div>

  <button
    on:click={submit_bookings}
    class="touch-none select-none duration-150 transition-colors rounded-lg bg-brand text-white px-8 py-2 hover:bg-brand-surface-hover outline-transparent focus-visible:ring-2 ring-offset-2 focus-visible:ring-brand"
  >
    go
  </button>
</section>
