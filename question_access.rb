require 'json'
require 'date'
require 'groupdate'

file = File.read('./question_access.json')
question_list_json = JSON.parse(file, object_class:OpenStruct)


dd = question_list_json.map {|a|
    a.date=DateTime.parse(a.date) 
    a
}
ff =  dd.sort_by{ |h| h[:date]}


# Agrupa por speriodo de acesso 
orderby_access_week = ff.group_by { |iten| [iten.question_id, iten.date.strftime("%Y-%V")] }
orderby_access_month = ff.group_by { |iten| [iten.question_id, iten.date.strftime("%Y-%m")] }
orderby_access_year = ff.group_by { |iten| [iten.question_id, iten.date.strftime("%Y")] }

# Calcula quantidade total de acesso por questao e separa os dados relevantes
map_access_week = orderby_access_week.map {|a,b| { question:a[0],week:a[1],total_accessed:b.sum{|v| v.times_accessed} } }
map_access_month = orderby_access_month.map {|a,b| { question:a[0],month:a[1],total_accessed:b.sum{|v| v.times_accessed} } }
map_access_year = orderby_access_year.map {|a,b| { question:a[0],year:a[1],total_accessed:b.sum{|v| v.times_accessed} } }

# Ordem crescente da data e decrescente da quantidade de acesso
sort_by_week =  map_access_week.sort_by{ |h| [h[:week],-h[:total_accessed]]}
sort_by_month =  map_access_month.sort_by{ |h| [h[:month],-h[:total_accessed]]}
sort_by_year =  map_access_year.sort_by{ |h| [h[:year],-h[:total_accessed]]}


puts "Questões mais acessadas por periodo:"
puts "Semana: "
sort_by_week.each do |n|
    puts "Questao: #{n[:question]}"
    puts "Semana: #{n[:week]}"
    puts "Quantidade de acesso: #{n[:total_accessed]}"
    puts "............................................."
end
puts "--------------------------------------------------------------------------------------------------------------------------"

puts "Mês: "
sort_by_month.each do |n|
    puts "Questao: #{n[:question]}"
    puts "Mês: #{n[:month]}"
    puts "Quantidade de acesso: #{n[:total_accessed]}"
    puts "............................................."
end
puts "--------------------------------------------------------------------------------------------------------------------------"

puts "Ano: "
sort_by_year.each do |n|
    puts "Questao: #{n[:question]}"
    puts "Ano: #{n[:year]}"
    puts "Quantidade de acesso: #{n[:total_accessed]}"
    puts "............................................."
end
puts "--------------------------------------------------------------------------------------------------------------------------"
