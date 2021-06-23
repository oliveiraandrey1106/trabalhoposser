require_relative "translator"

puts(" Translator ")
puts('Languages:')
puts('EnUs - English (US)')
puts('PtBr - Brazilian portuguese')
puts('DeAl - German')
puts('ZhCh - Chinese')


print("Write your message to translate: ")
message = gets.chomp.to_s

print("Wich language is it ?: ")
from = gets.chomp.to_s

print("Transtale to: ")
to = gets.chomp.to_s

translator = Translator.new
result = translator.translate(message, from, to )

puts result