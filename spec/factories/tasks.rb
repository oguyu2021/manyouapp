FactoryBot.define do
  factory :task do
    title { 'Sample Task' }
    content { 'Sample Task Content' }
    priority { "低" }
  end
end
