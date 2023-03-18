defmodule SvoenixWeb.Header do
  use SvoenixWeb, :html

  def render(assigns) do
    ~H"""
    <header class="h-[52px] bg-opacity-[0.75] sticky top-0 z-20 flex items-center border-b border-gray-100 bg-white px-4 backdrop-blur-lg">
      <div class="w-main-content mx-auto flex items-center justify-between">
        <.link class="text-lg font-bold hover:text-gray-700" navigate={~p"/"}>
          IRLcafé
        </.link>
      </div>
    </header>
    """
  end
end
