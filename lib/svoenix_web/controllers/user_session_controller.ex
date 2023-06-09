defmodule SvoenixWeb.UserSessionController do
  use SvoenixWeb, :controller

  alias Svoenix.Accounts
  alias SvoenixWeb.UserAuth

  def create(conn, %{"_action" => "registered"} = params) do
    # create(conn, params, "Account created successfully!")
    create(conn, params, nil)
  end

  def create(conn, %{"_action" => "password_updated"} = params) do
    conn
    |> put_session(:user_return_to, ~p"/settings")
    |> create(params, "Password updated successfully!")
  end

  def create(conn, params) do
    # create(conn, params, "Welcome back!")
    create(conn, params, nil)
  end

  def delete(conn, _params) do
    conn
    # |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end

  ### Helpers

  defp create(conn, %{"user" => user_params}, info) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      conn
      |> then(&if info, do: put_flash(&1, :info, info), else: &1)
      |> UserAuth.log_in_user(user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn
      |> put_flash(:error, "Invalid email or password")
      |> put_flash(:email, String.slice(email, 0, 160))
      |> redirect(to: ~p"/log_in")
    end
  end
end
