defmodule SvoenixWeb.Layouts do
  use SvoenixWeb, :html

  # embed_templates "layouts/*"

  def render("app.html", assigns) do
    assigns = assign_new(assigns, :city, fn -> nil end)

    ~H"""
    <main class="min-h-[100dvh] min-h-screen">
      <.flash_group flash={@flash} />

      <SvoenixWeb.Header.render city={@city} />

      <div class="max-w-2xl mx-auto py-8 md:py-16">
        <%= @inner_content %>
      </div>
    </main>
    """
  end

  def render("root.html", assigns) do
    ~H"""
    <!DOCTYPE html>
    <html lang="en" style="scrollbar-gutter: stable;">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="csrf-token" content={get_csrf_token()} />

        <meta name="theme-color" content="#111827" />
        <meta name="description" content="find the best spots near you and meet coffee buddies." />

        <.live_title><%= assigns[:page_title] || "IRL café" %></.live_title>

        <link rel="manifest" href={~p"/manifest.json"} />
        <link rel="icon" href={~p"/favicon.ico"} />
        <%!-- <link rel="icon" href={~p"/favicon.ico"} sizes="any" /> --%>
        <%!-- <link rel="icon" href={~p"/images/icons/icon.svg"} type="image/svg+xml" /> --%>
        <link rel="apple-touch-icon" href={~p"/images/icons/apple-touch-icon.png"} />

        <link phx-track-static rel="stylesheet" href={~p"/assets/app.css"} />

        <script defer phx-track-static type="text/javascript" src={~p"/assets/app.js"}>
        </script>
      </head>

      <body class="bg-background antialiased">
        <%= @inner_content %>
      </body>
    </html>
    """
  end
end
