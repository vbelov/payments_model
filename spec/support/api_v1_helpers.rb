module ApiV1Helpers
  def v1_list(klass)
    type = klass.name.tableize.dasherize
    get "/api/v1/#{type}"
    v1_check_errors
  end

  def v1_show(object)
    endpoint =
        if object.is_a?(Product)
          "/api/v1/products/#{object.code}"
        elsif object.is_a?(SubscriptionPeriod)
          "/api/v1/subscription-periods/#{object.code}"
        else
          type = object.class.name.tableize
          "/api/v1/#{type}/#{object.id}"
        end
    get endpoint
    v1_check_errors
  end

  def v1_create(klass, attributes)
    type = klass.name.tableize
    data = {data: {type: type, attributes: attributes}}
    # noinspection RubyStringKeysInHashInspection
    post "/api/v1/#{type}",
         params: data.to_json,
         headers: {
             'CONTENT_TYPE' => 'application/vnd.api+json'
         }
    v1_check_errors
  end

  # noinspection RubyStringKeysInHashInspection
  def v1_update(object, attributes)
    type = object.class.name.tableize
    endpoint = "/api/v1/#{type}/#{object.id}"
    data = {data: {type: type, id: object.id, attributes: attributes}}
    patch endpoint,
          params: data.to_json,
          headers: {
              'CONTENT_TYPE' => 'application/vnd.api+json'
          }
    v1_check_errors
  end

  # noinspection RubyStringKeysInHashInspection
  def v1_delete(object)
    type = object.class.name.tableize
    endpoint = "/api/v1/#{type}/#{object.id}"
    data = {data: {type: type, id: object.id}}
    delete endpoint,
           params: data.to_json,
           headers: {
               'CONTENT_TYPE' => 'application/vnd.api+json'
           }
    v1_check_errors
  end

  def v1_check_errors
    # if response.code.to_i / 100 == 4
    #   ap JSON.parse(response.body)
    # end
    if response.code.to_i / 100 == 5
      meta = v1_response['errors'].first['meta']
      puts meta['exception']
      meta['backtrace'].each { |l| puts l }
      fail meta['exception']
    end
  end

  def v1_response
    JSON.parse(response.body)
  end
end

RSpec.configure do |c|
  c.include ApiV1Helpers
end
