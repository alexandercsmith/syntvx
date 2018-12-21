class ToolCategory < ApplicationRecord
  belongs_to :tool, touch: true
  belongs_to :category, touch: true
end
