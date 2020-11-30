require 'json'

file = File.read('./questions.json')
question_list_json = JSON.parse(file, object_class:OpenStruct)

# Agrupando por disciplina
discipline_group = question_list_json.group_by { |iten| iten.discipline }
# Calculando quantidade de acesso por disciplina
discipline_group_access = discipline_group.map {|a,b| { discipline:a,access:b.sum{|v| v.daily_access} } }
# Ordenando de acordo com quantidade de acesso, ordem decrescente
orderby_access = discipline_group_access.sort_by{ |h| -h[:access]}


puts "Disciplinas com questões mais quentes:"
orderby_access.each do |n|
    puts "Disciplina: #{n[:discipline]}"
    puts "Quantidade de acesso: #{n[:access]}"
    puts "............................................."
end
