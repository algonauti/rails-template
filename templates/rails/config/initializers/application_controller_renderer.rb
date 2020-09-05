# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

ActiveSupport::Reloader.to_prepare do
  ActionController::Renderers.add :jsonapi do |json, options|
    self.content_type = Mime[:jsonapi] if media_type.nil?
    self.response_body = "#{controller_name.classify}Serializer".constantize.new(json, {
      params: options.merge({
        current_user: current_user
      })
    }).serializable_hash.to_json
  end
end
