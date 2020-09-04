# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

ActiveSupport::Reloader.to_prepare do
  ActionController::Renderers.add :json do |object, options|
    self.content_type = Mime[:json] if media_type.nil?
    "#{object.class.name}Serializer".constantize.new(object, {
      params: options.merge({
        current_user: current_user
      })
    }).serializable_hash.to_json
  end
end
