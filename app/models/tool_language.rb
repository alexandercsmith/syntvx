class ToolLanguage < ApplicationRecord
  belongs_to :tool, touch: true
  belongs_to :language, touch: true
end
