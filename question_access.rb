require 'json'
require 'date'
require 'groupdate'

file = File.read('./question_access.json')
question_list_json = JSON.parse(file, object_class:OpenStruct)


convert_date = question_list_json.map {|a|
    a.date=DateTime.parse(a.date) 
    a
}

order_date =  convert_date.sort_by{ |h| h[:date]}

# Agrupa por speriodo de acesso 
orderby_access_week = order_date.group_by { |iten| [iten.question_id, iten.date.strftime("%Y-%V")] }
orderby_access_month = order_date.group_by { |iten| [iten.question_id, iten.date.strftime("%Y-%m")] }
orderby_access_year = order_date.group_by { |iten| [iten.question_id, iten.date.strftime("%Y")] }

# Calcula quantidade total de acesso por questao e separa os dados relevantes
map_access_week = orderby_access_week.map {|a,b| { question:a[0],week:a[1],total_accessed:b.sum{|v| v.times_accessed} } }
map_access_month = orderby_access_month.map {|a,b| { question:a[0],month:a[1],total_accessed:b.sum{|v| v.times_accessed} } }
map_access_year = orderby_access_year.map {|a,b| { question:a[0],year:a[1],total_accessed:b.sum{|v| v.times_accessed} } }

# Ordem crescente da data e decrescente da quantidade de acesso
sort_by_week =  map_access_week.sort_by{ |h| [h[:week],-h[:total_accessed]]}
sort_by_month =  map_access_month.sort_by{ |h| [h[:month],-h[:total_accessed]]}
sort_by_year =  map_access_year.sort_by{ |h| [h[:year],-h[:total_accessed]]}

file = File.read('./questions.json')
question_list_json = JSON.parse(file, object_class:OpenStruct)

key_list = question_list_json.map {|a| [a.id, a]}
hash_list = Hash[key_list]

puts "Questões mais acessadas por periodo:"
puts "Semana: "
sort_by_week.each do |n|
    
    iten = hash_list[n[:question]]
    puts "Disciplina: #{iten.discipline}"
    puts "Questao: (#{n[:question]}) - #{iten.text}"
    puts "Semana: #{n[:week]}"
    puts "Quantidade de acesso: #{n[:total_accessed]}"
    puts "............................................."
end
puts "--------------------------------------------------------------------------------------------------------------------------"

puts "Mês: "
sort_by_month.each do |n|
    iten = hash_list[n[:question]]
    puts "Disciplina: #{iten.discipline}"
    puts "Questao: (#{n[:question]}) - #{iten.text}"
    puts "Mês: #{n[:month]}"
    puts "Quantidade de acesso: #{n[:total_accessed]}"
    puts "............................................."
end
puts "--------------------------------------------------------------------------------------------------------------------------"

puts "Ano: "
sort_by_year.each do |n|
    iten = hash_list[n[:question]]
    puts "Disciplina: #{iten.discipline}"
    puts "Questao: (#{n[:question]}) - #{iten.text}"
    puts "Ano: #{n[:year]}"
    puts "Quantidade de acesso: #{n[:total_accessed]}"
    puts "............................................."
end
puts "--------------------------------------------------------------------------------------------------------------------------"
