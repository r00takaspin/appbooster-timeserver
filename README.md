# Тестовое задание Вольдэмара Дулецкого в компанию Appbooster

## Задание

Написать на ruby web-сервер, который возвращает текущее время UTC. Опционально сервер может принимать названия городов и показывать текущее время для них.

Также сервер должен максимально быстро возвращать результат и поддерживать большое кол-во соединений.  

Примеры запросов:
```
/time

UTC: 2015-04-11 10:30:50

/time?Moscow,New%20York

UTC: 2015-04-11 10:30:50
Moscow: 2015-04-11 13:30:50
New York: 2015-04-11 02:30:50
```

## Цель

Обеспечить стабильный веб-сервис работащий на процессах для обеспеченя максимального числа одновременных соединений. В основу была взята модель работы веб-сервера Unicorn.

## SETUP


Для работы скрипта необходимо выполнить следующие действия:

```
brew install vegeta #установка тулзы для бенчмарка
cd %ПУТЬ_ДО_ПРОЕКТА_%
bundle install
ruby ./utc.rb #запускаем версию в один поток
ruby ./utc_process.rb #запускаем в несколько процессов
```


## Бенчмарки
   *результаты справедливы для Macbook Pro 4x 2,2 GHz Intel Core i7, 16 Gb RAM

### Одним процессом


```
➜  ~ echo "GET http://localhost:8081/time?Kaliningrad,Moscow,Petersburg" | vegeta attack -duration=30s -rate=200 | tee results.bin | vegeta report

Requests      [total, rate]            6000, 200.03
Duration      [total, attack, wait]    29.997413377s, 29.994999771s, 2.413606ms
Latencies     [mean, 50, 95, 99, max]  530.770787ms, 374.862024ms, 1.532831826s, 1.663431075s, 1.717920767s
Bytes In      [total, mean]            514917, 85.82
Bytes Out     [total, mean]            0, 0.00
Success       [ratio]                  73.35%
Status Codes  [code:count]             200:4401  0:1599
```

Видим, что число необработанных запросов порядка 25%

### При использовании мультипроцессовой версии 

```

➜  ~ echo "GET http://localhost:8082/time?Kaliningrad,Moscow,Petersburg" | vegeta attack -duration=30s -rate=200 | tee results.bin | vegeta report

Requests      [total, rate]            6000, 200.03
Duration      [total, attack, wait]    29.998023499s, 29.994999908s, 3.023591ms
Latencies     [mean, 50, 95, 99, max]  2.902841ms, 2.816928ms, 3.604252ms, 4.420398ms, 26.696699ms
Bytes In      [total, mean]            700596, 116.77
Bytes Out     [total, mean]            0, 0.00
Success       [ratio]                  99.80%
Status Codes  [code:count]             200:5988  0:12
```

Видим, что число необработанных запросов порядка 0.23%

## Итог:
В мультипроцессовом режиме веб-сервис держит 350 одновременных соединений с долей удачных ответов в 99.5%
 
![Image](https://media.giphy.com/media/JBysUxnowXxS0/giphy.gif)