<script lang="ts">
  import Slot from "./Slot.svelte";
  import { formatDate } from "../utils/dates.utils";
  import addDays from "date-fns/addDays";

  export let place;
  $: console.log("place", place);

  export let request;

  const today_date = new Date();
  const tomorrow_date = addDays(today_date, 1);
  const today = today_date.toISOString().split("T")[0];
  const tomorrow = tomorrow_date.toISOString().split("T")[0];

  const bookings = [
    { date: today, slot: "morning" },
    { date: today, slot: "lunch" },
    { date: today, slot: "afternoon" },
    { date: today, slot: "afterwork" },
    { date: tomorrow, slot: "morning" },
    { date: tomorrow, slot: "lunch" },
    { date: tomorrow, slot: "afternoon" },
    { date: tomorrow, slot: "afterwork" },
  ];

  const today_bookings = bookings.filter(({ date }) => date === today);
  const tomorrow_bookings = bookings.filter(({ date }) => date === tomorrow);

  $: selected_bookings = place.bookings.filter((booking) =>
    [today, tomorrow].includes(booking.date)
  );

  function submit_bookings() {
    if (selected_bookings.length > 0) {
      request(
        "submit_bookings",
        { slots: selected_bookings, place_id: place.id },
        ({ bookings }) => {
          // TODO: Success UI with timeout to reset UI.
          console.log("success!");
        }
      );
    }
  }

  function is_today_slot_available(booking) {
    const hours = new Date().getHours();

    switch (booking.slot) {
      case "morning":
        return hours < 12;
      case "lunch":
        return hours < 14;
      case "afternoon":
        return hours < 17;
      case "afterwork":
        return hours < 21;
      default:
        return true;
    }
  }
</script>

<section
  class="flex rounded-base flex-col gap-8 items-start p-5 absolute inset-0 z-10 bg-background/90 backdrop-blur-lg"
>
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
          bind:selected_bookings
          available={is_today_slot_available(booking)}
          {booking}
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
        <Slot bind:selected_bookings available={true} {booking}>
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
</section>
