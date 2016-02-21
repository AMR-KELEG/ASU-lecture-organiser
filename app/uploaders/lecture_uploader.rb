# encoding: utf-8
require 'fileutils'

class LectureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick

  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def store_dir
    @time_stamp = Time.now.utc.strftime('%Y%m%e%H%M%S%L')
    "data/lectures/#{@time_stamp}"
  end

  def lecture_folder_path(time)
    "/data/lectures/#{time}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process :explode_to_images


  #thumb = pdf.scale(300, 300)
  #thumb.write "doc.png"


  def check_dir(file_path)
    dirname = File.dirname(file_path)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
  end

  def explode_to_images
    model.path = lecture_path(file.basename)
    model.tag_list=["TODO: must fix this"]
    model.user_id=10    
    model.save!
    pdf = Magick::ImageList.new(file.path)
    counter = 0
    pdf.each do |page|
      slide_path = image_path(file.basename, counter+1)
      model.slides.create! path:slide_path, page_number: counter+1

      check_dir "public/#{slide_path}"
      page.write "public/#{slide_path}"

      counter += 1
    end
  end

  def image_path(lecture_title, page_num)
    "#{lecture_folder_path(@time_stamp)}/slides/#{page_num}.png"
  end

  def lecture_path(lecture_title)
    "#{lecture_folder_path(@time_stamp)}/#{lecture_title}.pdf"
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end



  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(pdf)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  #def filename
  #   "something.jpg" if original_filename
  # end

end

