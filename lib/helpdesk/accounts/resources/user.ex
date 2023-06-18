defmodule Helpdesk.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication]

  attributes do
    uuid_primary_key :id
    attribute :email, :ci_string, allow_nil?: false
    attribute :hashed_password, :string, allow_nil?: false, sensitive?: true
  end

  authentication do
    api Helpdesk.Accounts

    strategies do
      password :password do
        identity_field :email
        sign_in_tokens_enabled? true
      end
    end

    tokens do
      enabled? true
      token_resource Helpdesk.Accounts.Token
      signing_secret Application.compile_env(:helpdesk, HelpdeskWeb.Endpoint)[:secret_key_base]
    end
  end

  postgres do
    table "users"
    repo Helpdesk.Repo
  end

  identities do
    identity :unique_email, [:email]
  end

  # If using policies, add the folowing bypass:
  # policies do
  #   bypass AshAuthentication.Checks.AshAuthenticationInteraction do
  #     authorize_if always()
  #   end
  # end
end
