# petsonic_parser
### Описание
https://www.petsonic.com/galletas-para-perro/

По урлу находится категория веб сайта, который занимается продажей товаров для животных. Нужно собрать все товары из категории и записать в csv файл.
Парсер собирает: название, цену и ссылку на изображение.

На странице мультипродукта может находится информация о нескольких разновидностях продукта, например различная весовка (200 gr, 8 kg) и цены соответсвенно.

В таком случае в файле будет две записи с разными весовками и ценами.
В названии: Galletas Granja para Perro -  200 gr
В цене: 1.35
В Изображении: http://www.petsonic.com/5830-large_default/galletas-granja-para-perro.jpg

### Запуск
На вход скрипт получает 2 параметра: ссылку на категорию товаров и название файла.

```
$ ruby run.rb url file_name

```

Пример:

```
$ ruby run.rb https://www.petsonic.com/galletas-para-perro/ galetas

``` 
или

```
ruby run.rb https://www.petsonic.com/galletas-para-perro/ galetas.csv

```

###Вывод в терминале
После запуска скрипта появится:

I found 32 products
The data was writed into ../data/galetas.csv



