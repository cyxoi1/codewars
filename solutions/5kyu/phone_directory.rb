def phone(strng, num)
  array = []
  array_of_strings = strng.gsub(/\n/, 'and_of_string').split('and_of_string')
  array_of_strings.each do |string|
    temp = []
    temp << string.scan(/(\d{1,2})-(\d{1,3})-(\d{1,3})-(\d{1,4})/).join('-')
    string.gsub!(/(\d{1,2})-(\d{1,3})-(\d{1,3})-(\d{1,4})/, '')
    temp << string.scan(/(<[a-zA-Z]+>)|(<[a-zA-Z]+ [a-zA-Z]+>)|(<[a-zA-Z]+ [a-zA-Z']+>)/).flatten.compact[0].gsub(/<|>/, '')
    string.gsub!(/(<[a-zA-Z]+>)|(<[a-zA-Z]+ [a-zA-Z]+>)|(<[a-zA-Z]+ [a-zA-Z']+>)/, '')
    temp << string.gsub(/[_]/, ' ').gsub(%r{[!@%&$+;:*/_\",?]}, '').split.join(' ')
    array << temp
  end

  array.map! do |element|
    "Phone => #{element[0]}, Name => #{element[1]}, Address => #{element[2]}" if element[0] == num
  end
  array.compact!
  case array.size
  when 0
    "Error => Not found: #{num}"
  when 1
    array[0]
  when 2
    "Error => Too many people: #{num}"
  end
end

string = "/+1-541-754-3010 156 Alphand_St. <J Steeve>\n 133, Green, Rd. <E Kustur> NY-56423 ;+1-541-914-3010;\n"\
"+1-541-984-3012 <P Reed> /PO Box 530; Pollocksville, NC-28573\n :+1-321-512-2222 <Paul Dive> Sequoia Alley PQ-67209\n"\
"+1-741-984-3090 <Peter Reedgrave> _Chicago\n :+1-921-333-2222 <Anna Stevens> Haramburu_Street AA-67209\n"\
"+1-111-544-8973 <Peter Pan> LA\n +1-921-512-2222 <Wilfrid Stevens> Wild Street AA-67209\n"\
"<Peter Gone> LA ?+1-121-544-8974 \n <R Steell> Quora Street AB-47209 +1-481-512-2222!\n"\
"<Arthur Clarke> San Antonio $+1-121-504-8974 TT-45120\n <Ray Chandler> Teliman Pk. !+1-681-512-2222! AB-47209,\n"\
"<Sophia Loren> +1-421-674-8974 Bern TP-46017\n <Peter O'Brien> High Street +1-908-512-2222; CC-47209\n"\
"<Anastasia> +48-421-674-8974 Via Quirinal Roma\n <P Salinger> Main Street, +1-098-512-2222, Denver\n"\
"<C Powel> *+19-421-674-8974 Chateau des Fosses Strasbourg F-68000\n <Bernard Deltheil> +1-498-512-2222; Mount Av.  Eldorado\n"\
"+1-099-500-8000 <Peter Crush> Labrador Bd.\n +1-931-512-4855 <William Saurin> Bison Street CQ-23071\n"\
"<P Salinge> Main Street, +1-098-512-2222, Denve\n"

p phone(string, '48-421-674-8974') # "Phone => 48-421-674-8974, Name => Anastasia, Address => Via Quirinal Roma")
p phone(string, '1-121-504-8974') # , "Phone => 1-121-504-8974, Name => Arthur Clarke, Address => San Antonio TT-45120")
p phone(string, '1-098-512-2222') # , "Error => Too many people: 1-098-512-2222")$dr, "1-098-512-2222"), "Error => Too many people: 1-098-512-2222")
p phone(string, '5-555-555-5555') # , "Error => Not found: 5-555-555-5555")
p phone(string, '1-541-754-3010') # , "Phone => 1-541-754-3010, Name => J Steeve, Address => 156 Alphand St.")

# BEST practice
# def phone(strng, num)
#   a = strng.scan(/.*#{num}.*/)
#   return "Error => Too many people: #{num}" if a.size > 1
#   return "Error => Not found: #{num}" if a.empty?
#   a = a.first
#   "Phone => #{num}, Name => #{a[/<(.*)>/, 1]}, Address => #{a.gsub(/[^ ]*#{num}[^ ]*|<.*>|[,;\/]/,'')}".gsub(/[\s_]+/,' ').strip
# end
