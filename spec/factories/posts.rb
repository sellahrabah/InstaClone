FactoryBot.define do
    factory :post do
      title { "Post Title" }
      description { "Post Description" }
      keyword { "keyword" }
      user
    end
end