class ApplicationSerializer
  include JSONAPI::Serializer

  attributes :created_at, :updated_at
end
