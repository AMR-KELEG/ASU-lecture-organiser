require 'RMagick'
path="./Module2-Lecture1.pdf"
pdf = Magick::ImageList.new(path)
#thumb = pdf.scale(300, 300)
counter=0
pdf.each do |page|
	page.write "#{counter}.png"
	counter+=1
end
#thumb.write "doc.png"
