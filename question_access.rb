require 'json'
require 'ap'
require 'date'

file = File.read('./question_access.json')
question_list_json = JSON.parse(file, object_class:OpenStruct)

# Agrupa por semana,mês e ano de acesso e calcula quantidade total de acesso por questao
orderby_access_week = question_list_json.group_by { |iten| [iten.question_id, DateTime.parse(iten.date).strftime("Y-%m-%V")] }
orderby_access_month = question_list_json.group_by { |iten| [iten.question_id, DateTime.parse(iten.date).strftime("%Y-%m")] }
orderby_access_year = question_list_json.group_by { |iten| [iten.question_id, DateTime.parse(iten.date).strftime("%Y")] }


pust "Total de acesso por semana:"
pp orderby_access_week

pust "Total de acesso por mês:"
pp orderby_access_month 

pust "Total de acesso por ano:"
pp orderby_access_year