# frozen_string_literal: true

# Add root-level fields here.
# They will be entry points for queries on your schema.
class Types::QueryType < Types::BaseObject
  include Types::Queries::Country
  include Types::Queries::Category
  include Types::Queries::Store
  include Types::Queries::Item
  include Types::Queries::Warranty

  field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
    argument :id, ID, required: true, description: 'ID of the object.'
  end

  def node(id:)
    context.schema.object_from_id(id, context)
  end

  field :nodes, [Types::NodeType, { null: true }], null: true,
                                                   description: 'Fetches a list of objects given a list of IDs.' do
    argument :ids, [ID], required: true, description: 'IDs of the objects.'
  end

  def nodes(ids:)
    ids.map { |id| context.schema.object_from_id(id, context) }
  end

  # Add root-level fields here.
  # They will be entry points for queries on your schema.
end
