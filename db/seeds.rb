# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
User.create! username: "amr", password: "123"
20.times do |i|
  User.create! username: "user#{i}", password: "pass#{i}"
end

Lecture.destroy_all
Slide.destroy_all
Comment.destroy_all

Dir.foreach('./public/data/lectures') do |lecture_file|
  next if lecture_file == '.' or lecture_file == '..'
  
  lecture = Lecture.new(name: lecture_file)

  Dir.foreach('./public/data/slides/' + lecture_file.split('.')[0]) do |slide_file|
    next if slide_file == '.' or slide_file == '..'
    slide = Slide.new(
      path: '/data/slides/' + lecture_file.split('.')[0] + '/' + slide_file,
      page_number: slide_file.split('.')[0].to_i
      )
    slide.lecture = lecture
    slide.save
  end
  lecture.save
end

Slide.all.each do |slide|
  10.times do
    comment = slide.comments.new text: ('a'..'z').to_a.shuffle[0,20].join
    comment.user = User.order("RANDOM()").first
    comment.save!
  end
end