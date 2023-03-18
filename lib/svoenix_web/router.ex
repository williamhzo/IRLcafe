defmodule SvoenixWeb.Router do
  use SvoenixWeb, :router

  import SvoenixWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SvoenixWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SvoenixWeb do
    pipe_through :browser

    live "/", HomeLive, :home

    live "/test", TestLive, :index

    live "/places", PlaceLive.Index, :index
    live "/places/new", PlaceLive.Index, :new
    live "/places/:id/edit", PlaceLive.Index, :edit
    live "/places/:id", PlaceLive.Show, :show
    live "/places/:id/show/edit", PlaceLive.Show, :edit

    live "/cities", CityLive.Index, :index
    live "/cities/new", CityLive.Index, :new
    live "/cities/:id/edit", CityLive.Index, :edit
    live "/cities/:id", CityLive.Show, :show
    live "/cities/:id/show/edit", CityLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", SvoenixWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:svoenix, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SvoenixWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", SvoenixWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{SvoenixWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/register", UserRegistrationLive, :new
      live "/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/log_in", UserSessionController, :create
  end

  scope "/", SvoenixWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{SvoenixWeb.UserAuth, :ensure_authenticated}] do
      live "/settings", UserSettingsLive, :edit
      live "/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", SvoenixWeb do
    pipe_through :browser

    delete "/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{SvoenixWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end

    # NOTE: Please keep at the end of the router,
    #       because looks like a catch-all route.
    live "/:city_slug", AppLive, :index
  end
end
