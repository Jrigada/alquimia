defmodule AlquimiaWeb.ListingControllerTest do
  use AlquimiaWeb.ConnCase

  import Alquimia.ListingsFixtures

  @create_attrs %{description: "some description", price: "120.5", title: "some title"}
  @update_attrs %{
    description: "some updated description",
    price: "456.7",
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, price: nil, title: nil}

  describe "index" do
    test "lists all listings", %{conn: conn} do
      conn = get(conn, ~p"/listings")
      assert html_response(conn, 200) =~ "Listing Listings"
    end
  end

  describe "new listing" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/listings/new")
      assert html_response(conn, 200) =~ "New Listing"
    end
  end

  describe "create listing" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/listings", listing: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/listings/#{id}"

      conn = get(conn, ~p"/listings/#{id}")
      assert html_response(conn, 200) =~ "Listing #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/listings", listing: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Listing"
    end
  end

  describe "edit listing" do
    setup [:create_listing]

    test "renders form for editing chosen listing", %{conn: conn, listing: listing} do
      conn = get(conn, ~p"/listings/#{listing}/edit")
      assert html_response(conn, 200) =~ "Edit Listing"
    end
  end

  describe "update listing" do
    setup [:create_listing]

    test "redirects when data is valid", %{conn: conn, listing: listing} do
      conn = put(conn, ~p"/listings/#{listing}", listing: @update_attrs)
      assert redirected_to(conn) == ~p"/listings/#{listing}"

      conn = get(conn, ~p"/listings/#{listing}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, listing: listing} do
      conn = put(conn, ~p"/listings/#{listing}", listing: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Listing"
    end
  end

  describe "delete listing" do
    setup [:create_listing]

    test "deletes chosen listing", %{conn: conn, listing: listing} do
      conn = delete(conn, ~p"/listings/#{listing}")
      assert redirected_to(conn) == ~p"/listings"

      assert_error_sent 404, fn ->
        get(conn, ~p"/listings/#{listing}")
      end
    end
  end

  defp create_listing(_) do
    listing = listing_fixture()
    %{listing: listing}
  end
end
