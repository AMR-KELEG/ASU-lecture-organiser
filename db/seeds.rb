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

Dir.foreach('./public/data/lectures') do |lecture_file|
  next if lecture_file == '.' or lecture_file == '..'

  lecture = Lecture.create! name: lecture_file.split('.')[0], path: "/data/lectures/#{lecture_file}"
  lecture_title = lecture_file.split('.')[0]

  pdf = Magick::ImageList.new("./public/data/lectures/#{lecture_file}")
  counter = 1
  pdf.each do |page|
    slide_path = "/data/slides/#{lecture_title}/#{counter}.png"
    check_dir "public/#{slide_path}"
    page.write "public/#{slide_path}"

    counter += 1
  end

  Dir.foreach("./public/data/slides/#{lecture_title}") do |slide_file|
    next if slide_file == '.' or slide_file == '..'
    slide = lecture.slides.create! ({
      path: "/data/slides/#{lecture_title}/#{slide_file}",
      page_number: slide_file.split('.')[0].to_i
      })

    5.times do
      slide.comments.create! ({
        text: ('a'..'z').to_a.shuffle[0,20].join,
        user: User.all.sample,
        created_at: Time.now + (random.rand * 1e5).seconds,
        commentable_type: 'Slide',
        commentable_id: slide.id
        })
    end
  end
end
