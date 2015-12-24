# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'fileutils'

def check_dir(file_path)
  dirname = File.dirname(file_path)
  unless File.directory?(dirname)
    FileUtils.mkdir_p(dirname)
  end
end

User.destroy_all
User.create! username: "admin", password: "admin"
20.times do |i|
  User.create! username: "user#{i}", password: "pass#{i}"
end

Lecture.destroy_all
Slide.destroy_all
Comment.destroy_all

random = Random.new(Time.now.to_i)

Dir.foreach('./public/data/lectures') do |lecture_folder|
  next if lecture_folder == '.' or lecture_folder == '..'

  Dir.foreach("./public/data/lectures/#{lecture_folder}") do |file|
    next if file == '.' or file == '..' or file == 'slides'

    lecture_title = file.split('.')[0]
    lecture_path = "/data/lectures/#{lecture_folder}/#{file}"

    lecture = Lecture.create! name: lecture_title, path: lecture_path

    pdf = Magick::ImageList.new("./public/#{lecture_path}")
    counter = 1
    pdf.each do |page|
      slide_path = "/data/lectures/#{lecture_folder}/slides/#{counter}.png"
      check_dir "public/#{slide_path}"
      page.write "public/#{slide_path}"

      counter += 1
    end

    Dir.foreach("./public/data/lectures/#{lecture_folder}/slides") do |slide_file|
      next if slide_file == '.' or slide_file == '..'
      slide = lecture.slides.create! ({
        path: "/data/lectures/#{lecture_folder}/slides/#{slide_file}",
        page_number: slide_file.split('.')[0].to_i
        })

      3.times do
        slide.comments.create! ({
          text: ('a'..'z').to_a.shuffle[0,20].join,
          user: User.all.sample,
          created_at: Time.now.utc - (random.rand * 1e5).seconds,
          commentable_type: 'Slide',
          commentable_id: slide.id
          })
      end
    end
  end
end

lecture = Lecture.first
if lecture
  lecture.comments.create!({
  text: ('a'..'z').to_a.shuffle[0,20].join,
  user: User.all.sample,
  created_at: Time.now + (random.rand * 1e5).seconds,
  commentable_type: 'Lecture',
  commentable_id: Lecture.first.id
  })
end
