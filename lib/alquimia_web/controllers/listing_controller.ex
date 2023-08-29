defmodule AlquimiaWeb.ListingController do
  use AlquimiaWeb, :controller

  alias Alquimia.Listings
  alias Alquimia.Listings.Listing
  alias Alquimia.Repo

  def index(conn, _params) do
    listings = Listings.list_listings()
    render(conn, :index, listings: listings)
  end

  def new(conn, _params) do
    changeset = Listings.change_listing(%Listing{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"listing" => listing_params}) do
    user = conn.assigns.current_user
    changeset = Listing.changeset(%Listing{user_id: user.id}, listing_params)

    case Repo.insert(changeset) do
      {:ok, listing} ->
        conn
        |> put_flash(:info, "Listing created successfully.")
        |> redirect(to: AlquimiaWeb.Router.Helpers.listing_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    listing = Listings.get_listing!(id)
    render(conn, :show, listing: listing)
  end

  def edit(conn, %{"id" => id}) do
    listing = Listings.get_listing!(id)
    changeset = Listings.change_listing(listing)
    render(conn, :edit, listing: listing, changeset: changeset)
  end

  def update(conn, %{"id" => id, "listing" => listing_params}) do
    listing = Listings.get_listing!(id)

    case Listings.update_listing(listing, listing_params) do
      {:ok, listing} ->
        conn
        |> put_flash(:info, "Listing updated successfully.")
        |> redirect(to: ~p"/listings/#{listing}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, listing: listing, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    listing = Listings.get_listing!(id)
    {:ok, _listing} = Listings.delete_listing(listing)

    conn
    |> put_flash(:info, "Listing deleted successfully.")
    |> redirect(to: ~p"/listings")
  end
end
