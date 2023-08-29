defmodule Alquimia.ListingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Alquimia.Listings` context.
  """

  @doc """
  Generate a listing.
  """
  def listing_fixture(attrs \\ %{}) do
    {:ok, listing} =
      attrs
      |> Enum.into(%{
        description: "some description",
        price: "120.5",
        title: "some title"
      })
      |> Alquimia.Listings.create_listing()

    listing
  end
end
