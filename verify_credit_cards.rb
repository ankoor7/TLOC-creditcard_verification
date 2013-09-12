def type_of_card(card_number)
  case
  when ((card_number[0,4] == "6011") && (card_number.length == 16) )then return 'Discover'
  when (((card_number[0,2] == "37") || (card_number[0,2] == "34")) && (card_number.length == 15))  then 'AMEX'
  when ((card_number[0,2].to_i >= 51) && (card_number[0,2].to_i <= 55) ) then return 'MasterCard'
  when (
    (card_number[0] == "4") && ((card_number.length == 13) || (card_number.length == 16)) ) then return 'Visa'
  else "id_not_valid"
  end
end

def check_luhn(card_number)
  sum = 0
  card_number.reverse.split('').each_with_index { |item, index|
    if ((index % 2) == 1) then item = item.to_i * 2 else item = item.to_i end
      sum += item.to_s.split('').inject(0){ |memo,n| memo + n.to_i }
  }
  if ( ( sum % 10) == 0 ) then 'VALID' else 'failed' end
end

File.open(ARGV[0]).each { |number|
number.gsub!(/[\s\t\n]/, '')
    puts "#{type_of_card(number)}: #{number} - Luhn: #{check_luhn(number)}"
}
