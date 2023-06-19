defmodule HelpdeskWeb.Auth.SignInLive do
  use Phoenix.LiveView
  alias AshAuthentication.Phoenix.Components
  alias Phoenix.LiveView.{Rendered, Socket}

  @doc false
  @impl true
  def mount(_params, session, socket) do
    overrides =
      session
      |> Map.get("overrides", [AshAuthentication.Phoenix.Overrides.Default])

    socket =
      socket
      |> assign(overrides: overrides)
      |> assign_new(:otp_app, fn -> nil end)

    {:ok, socket}
  end

  @doc false
  @impl true
  @spec render(Socket.assigns()) :: Rendered.t()
  def render(assigns) do
    ~H"""
    <div class="grid h-screen place-items-center dark:bg-gray-900">
      <.live_component
        module={Components.SignIn}
        otp_app={@otp_app}
        id="sign-in"
        overrides={@overrides}
      />
    </div>
    """
  end
end
