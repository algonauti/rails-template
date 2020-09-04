# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end


module JsonApiSerializerSupport
  def __serialize_jsonapi(json, options)
    "#{json.class.name}Serializer".constantize.new(json, {
      params: options.merge({
        current_user: current_user
      })
    }).serializable_hash.to_json
  rescue NameError
    json&.to_json(options)
  end
end

ActiveSupport.on_load(:action_controller) do
  include JsonApiSerializerSupport
end

ActiveSupport::Reloader.to_prepare do
  ActionController::Renderers.add :jsonapi do |json, options|
    self.content_type = Mime[:jsonapi] if media_type.nil?
    self.response_body = __serialize_jsonapi(json, options)
  end
end
