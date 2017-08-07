# Модель платежной подсистемы

Для ознакомления с работой модели рекомендую в первую очередь прочитать [спек](spec/models/scenarios_spec.rb).


## Модели

[Диаграмма](doc/model_diagram.png)


### Subject - Предмет

Играет вспомогательную роль, как связующее звено между продуктами и курсами. 
В будущем, думаю, могут быть различные продукты для различных курсов одного и того же предмета.


### Product - Продукт

Продукт может принадлежать предмету.
Примеры продуктов: математика, игра "Счет на лету".


### SubscriptionPeriod - Период подписки

Периоды, на которые мы продаем подписку.
Примеры: месяц, год, до 31го мая, бессрочная.


### Bundle - Бандл (Пакет)

Это то, что продается. В бандле может один или несколько элементов - BundleItem.


### BundleItem - Элемент бандла

Представляет собой комбинацию продукта и периода подписки.


### Offer - Ценовое предложение

На один и тот же бандл может быть одни и более ценовое предложение. 
Ценовое предложение задает цену на бандл для определенного сегмента пользователей.


### Segment - Сегмент пользователей

Некоторое подмножество учеников. Возможны различные фильтры.


### Student - Ученик

Он самый.


### Order - Заказ

Заказ создается в момент, когда пользователь решает купить некоторый бандл. 
Чтобы получить доступ к продуктам бандла пользователь должен оплатить заказ.


### Payment - Платеж

Платеж создается на основании информации, поступающей от платежной платформы. 
В результате соответствующий заказ помечается как оплаченный 
и ученику предоставляется доступ к продуктам бандла.


### Subscription - Подписка

Подписка отражает факт наличия доступа ученика к определенному продукту и срок этого доступа.


## Основные методы модели

* `Bundle#find_offer(student)` - ценовое предложение на данный бандл для данного ученика
* `Bundle#create_order(student)` - создает заказ для оплаты
* `Payment#process` - выполняет обработку платежа; в частности создает необходимые подписки
* `Segment#contains?(student)` - принадлежит ли ученик данному сегменту
* `Student#subscriptions` - список подписок ученика
* `Student#find_subscription(product)` - подписка на заданный продукт
* `Student#apply_order(order)` - выдает ученику доступ (создает подписки) (вызывается после оплаты)


## Ньюансы/ограничения

Ограничения:
* пока не успел добавить АБ-тесты
* сейчас предполагается, что каждый бандл доступен всем студентам (всегда есть предложение по умолчанию)
* можно реализовать шаблонные сегменты, которые можно использовать в нескольких Предложениях. Сейчас предполагается,
  что Сегмент создается при создании Предложения.
* можно реализовать более гибкую систему сегментов
* нет приоритета офферов, если ученик принадлежит нескольким сегментам
* Subscription имеет другой смысл нежели сейчас в uchi.ru
