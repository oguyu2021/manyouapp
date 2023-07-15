FactoryBot.define do
  factory :user do
    name { 'testcode' }
    email { 'test@code.com' }
    password { 'testcode' }
  end

  factory :second_user, class: User do 
    name { 'manyou' }
    email { 'man@you.com' }
    password { 'manyoutest' }
  end

  factory :three_user, class: User do
    name { '管理者' }
    email { 'test@seed.com' }
    password { '654321' }
    admin {true}
  end
 
  factory :four_user, class: User do
    name { '管理者1' }
    email { 'test@seed1.com' }
    password { '654312' }
    admin {true}
  end
end