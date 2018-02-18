defmodule ShovikComWeb.LayoutView do
  use ShovikComWeb, :view

  @career_start_date ~D[2003-09-01]

  def page_title(%{assigns: %{title: title}}) when is_bitstring(title), do: "#{title} - Alex Kovshovik"
  def page_title(_), do: "Alex Kovshovik - Professional Software Consultant"

  def current_user_name(conn) do
    user = conn.assigns[:current_user]
    is_nil(user) && "Not Authenticated" || "#{user.first_name} #{user.last_name}"
  end

  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def years_of_experience do
    Timex.today.year - @career_start_date.year
  end

  def current_version do
    Application.loaded_applications
    |> Enum.filter(&(elem(&1, 0) == :shovik_com))
    |> List.first
    |> elem(2)
    |> to_string
  end
end
