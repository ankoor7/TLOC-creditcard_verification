ARGF.each { |number| number.gsub!(/\s/, '')
  type, sum  = [:Unknown, 0]
  type= :Discover if ((number[0,4].to_i == 6011) && (number.length == 16) )
  type= :AMEX if (((number[0,2].to_i == 37) || (number[0,2].to_i == 34)) && (number.length == 15))
  type= :MasterCard if ((number[0,2].to_i >= 51) && (number[0,2].to_i <= 55) )
  type= :Visa if ( (number[0].to_i == 4) && ((number.length == 13) || (number.length == 16)) )
  number.reverse.split('').each_with_index { |item, index|
    sum += (((index % 2) == 1) ? item.to_i * 2 : item.to_i).to_s.split('').inject(0){ |memo,n| memo + n.to_i } }
  puts "#{type}: #{number} - #{( ( sum % 10) == 0 ) ? '(valid)' : '(invalid)' }" }