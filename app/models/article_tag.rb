class ArticleTag < ApplicationRecord
  belongs_to :article, touch: true
  belongs_to :tag, touch: true
end
