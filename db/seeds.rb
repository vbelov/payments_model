# Продукты задаются на уровне кода
math = Product.find_by_code!('math')
english = Product.find_by_code!('english')
count_on_the_fly = Product.find_by_code!('count_on_the_fly')

# Периоды подписки задаются на уровне кода
year = SubscriptionPeriod.find_by_code!('year')
month = SubscriptionPeriod.find_by_code!('month')
unlimited = SubscriptionPeriod.find_by_code!('unlimited')
until_june = SubscriptionPeriod.find_by_code!('until_june')

Bundle.create!(
    name: 'Математика на месяц',
    price: 100
).add_item(math, month)

Bundle.create!(
    name: 'Математика на год',
    price: 800
).add_item(math, year)

Bundle.create!(
    name: 'Игра "Счет на лету"',
    price: 200
).add_item(count_on_the_fly, unlimited)

Bundle.create!(
    name: 'Математика на год и игра "Счет на лету" в подарок',
    price: 900
).add_item(math, year).add_item(count_on_the_fly, unlimited)
