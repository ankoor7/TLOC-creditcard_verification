def type_of_card(card_number)
  return 'Discover' if ((card_number[0,4] == "6011") && (card_number.length == 16) )
  return 'AMEX' if (((card_number[0,2] == "37") || (card_number[0,2] == "34")) && (card_number.length == 15))
  return 'MasterCard' if ((card_number[0,2].to_i >= 51) && (card_number[0,2].to_i <= 55) )
  return 'Visa' if (
    (card_number[0] == "4") && ((card_number.length == 13) || (card_number.length == 16)) )
  return "Unknown"
end

def check_luhn(card_number)
  sum = 0
  card_number.reverse.split('').each_with_index { |item, index|
    item = ((index % 2) == 1) ? item.to_i * 2 : item.to_i
      sum += item.to_s.split('').inject(0){ |memo,n| memo + n.to_i }
  }
  ( ( sum % 10) == 0 ) ? 'VALID' : 'failed'
end

File.open(ARGV[0]).each { |number|
number.gsub!(/[\s\t\n]/, '')
    puts "#{type_of_card(number)}: #{number} - Luhn: #{check_luhn(number)}"
}
