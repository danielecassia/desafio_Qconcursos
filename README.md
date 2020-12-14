
# Desafio Qconcursos
![ruby](https://user-images.githubusercontent.com/39657037/100154328-29fded00-2e84-11eb-998e-194fd8b65d20.png)

> Projeto desenvolvido para ler arquivo JSON e aplicar filtros sobre esse arquivo usando a linguagem Ruby <p>
>Filtros: <br>
>Disciplinas com questões mais quentes: Lista as disciplinas onde as questões foram as mais acessadas nas ultimas 24H. <br>
>Mais acessadas por periodo: Lista as questões mais acessadas por semana/mês/ano

	
## Exemplo de uso	

Leitura de arquivo Json
```ruby

file = File.read('./question_access.json')
question_list_json = JSON.parse(file, object_class:OpenStruct)
```



## Configuração para Desenvolvimento

 Instale as dependêcias
```sh	
install bundler	
```	
Para executar o arquivo
```sh
ruby arquivo.rb
```	

## Configuração Docker

 Disciplinas mais acessadas
```sh	
docker run danielecassia/discipline 		
```	
Acesso por período
```sh
docker run danielecassia/question 		

```	

## Meta	
Daniele Cassia – danielecassia9@gmail.com	<br>


## Contributing

1. Faça o _fork_ do projeto <https://github.com/Daniele-Cassia/desafio_Qconcursos>
2. Crie uma _branch_ para sua modificação `git checkout -b feature/fooBar`
3. Faça o _commit_ `git commit -am 'Add some fooBar'`
4. _Push_ `git push origin feature/fooBar`
5. Crie um novo _Pull Request_

