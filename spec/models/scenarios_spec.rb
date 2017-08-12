describe 'Комплекный сценарий работы модели' do
  it 'показывает как работает модель от начала до конца' do
    # Продукты задаются на уровне кода
    math = Product.find_by_code!('math')
    english = Product.find_by_code!('english')
    count_on_the_fly = Product.find_by_code!('count_on_the_fly')

    # Периоды подписки задаются на уровне кода
    year = SubscriptionPeriod.find_by_code!('year')
    unlimited = SubscriptionPeriod.find_by_code!('unlimited')
    until_june = SubscriptionPeriod.find_by_code!('until_june')

    # Бандлы можно создавать через админку
    super_bundle = Bundle.create!(
        name: 'Математика на год, Английский до 1 июня и игра "Счет на лету" в подарок',
        price: 900 # цена по умолчанию
    )
    super_bundle.add_item(math, year)
    super_bundle.add_item(count_on_the_fly, unlimited)
    super_bundle.add_item(english, until_june)

    # Предложения можно создавать через админку. При создании Предложения создаем Сегмент.
    # Можно будет сделать и иначе - иметь шаблоны Сегментов, из числа которых можно выбирать при создании Предложения.
    Offer.create!(
        bundle: super_bundle,
        segment: Segments::SimpleSegment.create!(
            region_ids: [77],
            levels: [], # без ограничения по классу
            b2what: nil, # и b2c, и b2t
        ),
        price: 1000
    )

    Offer.create!(
        bundle: super_bundle,
        segment: Segments::SimpleSegment.create!(
            region_ids: [5, 6, 7, 8, 9],
            levels: [1],
            b2what: 'b2c',
        ),
        price: 500
    )

    # Учеников регистрируют учителя и родители
    moscow_student = Student.create!(
        region_id: 77,
        level: 2,
        b2what: 'b2t'
    )
    dagestan_student = Student.create!(
        region_id: 5,
        level: 1,
        b2what: 'b2c'
    )
    magadan_student = Student.create!(
        region_id: 49,
        level: 3,
        b2what: 'b2t'
    )


    # На странице со списком доступных для покупки продуктов
    # ученик видит доступные ему бандлы и их цены
    offer = super_bundle.find_offer(moscow_student)
    expect(offer.price).to eq(1000)

    offer = super_bundle.find_offer(dagestan_student)
    expect(offer.price).to eq(500)

    offer = super_bundle.find_offer(magadan_student)
    expect(offer.price).to eq(900)

    # а также может перейти к оплате (создать заказ)
    order = super_bundle.create_order(moscow_student)
    expect(order.price).to eq(1000)

    order = super_bundle.create_order(dagestan_student)
    expect(order.price).to eq(500)

    order = super_bundle.create_order(magadan_student)
    expect(order.price).to eq(900)

    # Ученик совершает оплату. Из внешней системы к нам приходит извещение:
    payment = Payment.create!(
        student: magadan_student,
        order: order,
        amount: 900
    )

    # Мы обрабатываем этот платеж
    payment.process

    # У ученика создаются подписки на все продукты бандла
    expect(magadan_student.subscriptions.count).to eq(3)

    math_subscription = magadan_student.find_subscription(math)
    expect(math_subscription.end_date).to eq(Date.today + 366)

    count_subscription = magadan_student.find_subscription(count_on_the_fly)
    expect(count_subscription.end_date).to eq(Date.parse('2100-01-01'))

    english_subscription = magadan_student.find_subscription(english)
    expect(english_subscription.end_date).to eq(Date.parse('2018-05-31'))
  end
end
