defmodule ShovikCom.Picture do
  @moduledoc """
  Facilitates upload and transformaion of images for pages and blog posts.
  """

  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :page, :thumb]

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  end

  def transform(:page, _) do
    {:convert, "-resize 960x480>"}
  end

  # Override the persisted filenames:
  # def filename(version, _) do
  #   version
  # end

  # Override the storage directory:
  def storage_dir(_version, {_file, scope}) do
    "uploads/post_images/#{scope.post_id}"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  def s3_object_headers(_version, {_file, _scope}) do
    [content_disposition: "inline"]
  end
end
