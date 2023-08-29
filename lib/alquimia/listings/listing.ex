defmodule Alquimia.Listings.Listing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "listings" do
    field :description, :string
    field :price, :decimal
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(listing, attrs) do
    listing
    |> cast(attrs, [:title, :description, :price])
    |> validate_required([:title, :description, :price])
  end
end
