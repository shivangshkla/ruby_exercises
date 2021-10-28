require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

def clean_zipcode(zipcode)
	zipcode.to_s.rjust(5,'0')[0..4]
end

def legislators_by_zipcode(zip)
	civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials
    legislator_names = legislators.map(&:name)
    legislator_names.join(", ")
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def clean_phone_number(unclean_number)
	phone_number = ""
	unclean_number.each_byte do |digit|
		if digit >= 48 && digit <= 57
			phone_number+=(digit.chr)
		end
	end
	
	if phone_number.length < 10
		phone_number = "N/A"
	elsif phone_number.length == 11
		if phone_number[0] == '1'
			phone_number = phone_number[1..10]
		end
	elsif phone_number.length > 11
		phone_number = "N/A"
	else
		phone_number = phone_number
	end
     phone_number
end

def save_thank_you_letter(id,form_letter)
	Dir.mkdir('output') unless Dir.exist?('output')
	filename = "output/Thanks_#{id}.html"
	File.open(filename,'w') do |file|
		file.puts form_letter
	end
end
def peak_hours(date)
	time = Hash.new(0)
	date.sort
	date.map do |reg|
		date.map do |r|
			if reg == r
				time[reg] += 1
			end
		end
    end
	peak_users = 0
	peak_time = ""
	time.map do |key,value|
		if value > peak_users
			peak_users = value
			peak_time = key
		end
	end
    puts "Peak Hour: #{peak_time.hour}:00"
	puts "Peak Day: #{peak_time.wday}"
end

date = []
puts 'Event Manager Initialized!'
template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter
contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)
contents.each do |row|
    id = row[0]
	name = row[:first_name]
	zipcode = clean_zipcode(row[:zipcode])
	legislators = legislators_by_zipcode(zipcode)
	phone_number = clean_phone_number(row[:homephone])
	form_letter = erb_template.result(binding)
	date.append(Time.strptime(row[:regdate],"%Y/%d/%m %k"))
end
peak_hours(date)

