# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(number)
  clean_num = ''
  number.to_s.each_char { |char| clean_num += char if '0123456789'.include? char }

  clean_num = clean_num[1..10] if clean_num.length == 11 && clean_num[0] == '1'

  if clean_num.length == 10
    "#{clean_num[0..2]}-#{clean_num[3..5]}-#{clean_num[6..9]}"
  else
    '(No valid phone number provided)'
  end
end

def find_reg_hour(reg_date)
  Time.strptime(reg_date, '%m/%d/%y %k:%M').strftime('%I %p')
end

def find_reg_day(reg_date)
  Time.strptime(reg_date, '%m/%d/%y %k:%M').strftime('%A')
end

def update_hash(hash, val)
  if hash.key?(val)
    hash[val] += 1
  else
    hash[val] = 1
  end
end

def find_max(hash)
  hash.each_with_object({}) do |(k, v), h|
    (h[v] ||= []) << k
  end.max
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter
reg_hours = {}
reg_days = {}

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  phone_number = clean_phone_number(row[:homephone])

  reg_hour = find_reg_hour(row[:regdate])
  update_hash(reg_hours, reg_hour)

  reg_day = find_reg_day(row[:regdate])
  update_hash(reg_days, reg_day)

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  puts "#{name} #{phone_number}"
  # save_thank_you_letter(id, form_letter)
end

peak_hours = find_max(reg_hours)
peak_days = find_max(reg_days)

puts "\nThe peak registration hour(s) is(are) #{peak_hours[1].join(', and ')}.

The peak registration day(s) is(are) #{peak_days[1].join(', and ')}."
