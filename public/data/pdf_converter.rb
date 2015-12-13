require 'RMagick'
require 'fileutils'

def convert(pdf, lecture_title)
  counter=0
  pdf.each do |page|
    slide_file_name = "./slides/#{lecture_title}/#{counter}.png"
    check_dir slide_file_name
    page.write slide_file_name
    p slide_file_name
    counter += 1
  end
end

def converted?(lecture_title)
  File.exist?("./slides/#{lecture_title}")
end

def lecture_title(file_name)
  file_name.split('.')[0]
end

def check_dir(file_path)
  dirname = File.dirname(file_path)
  unless File.directory?(dirname)
    FileUtils.mkdir_p(dirname)
  end
end

def convert_all
  Dir.foreach('./lectures/') do |file_name|
    next if file_name == '.' or file_name == '..'

    file_path = "./lectures/#{file_name}"

    convert(
      Magick::ImageList.new(file_path),
      lecture_title(file_name)
      ) unless converted?(lecture_title(file_name))
  end
end

convert_all

#thumb = pdf.scale(300, 300)
#thumb.write "doc.png"
