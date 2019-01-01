# ORDERING
#
# ~/app/models/concerns
#
# Model: include Ordering
#
# Model.name_asc     => Name (A -> Z)
# Model.name_desc    => Name (Z -> A)
# Model.created_asc  => Created (First -> Last)
# Model.created_desc => Created (Last -> First)
# Model.updated_asc  => Updated (First -> Last)
# Model.updated_desc => Updated (Last -> First)

module Ordering
  extend ActiveSupport::Concern
  included do
    scope :name_asc,     -> { order(name: :asc) }
    scope :name_desc,    -> { order(name: :desc) }
    scope :created_asc,  -> { order(created_at: :asc) }
    scope :created_desc, -> { order(created_at: :desc) }
    scope :updated_asc,  -> { order(updated_at: :asc) }
    scope :updated_desc, -> { order(updated_at: :desc) }
  end
  class_methods do
  end
end
