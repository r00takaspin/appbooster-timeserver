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
➜  ~ echo "GET http://localhost:8082/time?Kaliningrad,Moscow,Petersburg" | vegeta attack -duration=30s -rate=200 | tee results.bin | vegeta report

Requests      [total, rate]            6000, 200.03
Duration      [total, attack, wait]    29.996867389s, 29.9949999s, 1.867489ms
Latencies     [mean, 50, 95, 99, max]  554.270111ms, 406.18973ms, 1.55735098s, 1.721280593s, 1.829983441s
Bytes In      [total, mean]            542574, 90.43
Bytes Out     [total, mean]            0, 0.00
Success       [ratio]                  70.10%
Status Codes  [code:count]             200:4206  0:1794
```

Видим, что число необработанных запросов порядка 30%

### При использовании мультипроцессовой версии 

```

➜  ~ echo "GET http://localhost:8082/time?Kaliningrad,Moscow,Petersburg" | vegeta attack -duration=30s -rate=200 | tee results.bin | vegeta report

Requests      [total, rate]            6000, 200.03
Duration      [total, attack, wait]    29.998639212s, 29.994999916s, 3.639296ms
Latencies     [mean, 50, 95, 99, max]  3.555889ms, 2.785235ms, 3.969807ms, 11.865394ms, 168.3134ms
Bytes In      [total, mean]            772194, 128.70
Bytes Out     [total, mean]            0, 0.00
Success       [ratio]                  99.77%
Status Codes  [code:count]             200:5986  0:14
```

Видим, что число необработанных запросов порядка 0.23%