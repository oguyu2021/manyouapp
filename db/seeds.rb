# User.create!(
#   name: 'taro',
#   email: 'user@example.com',
#   password_digest: 'useruser',
# )

# User.create!(name:  "管理者",
#              email: "admin@example.jp",
#              password:  "11111111",
#              #password_digest: "11111111",
#              admin: true)

# User.create!(name:  "管理",
#              email: "admin2@example.jp",
#              password:  "11111111",
#              admin: true)

10.times do |i|
  Label.create!(title: "sample#{i + 1}")
end

# User.create!(
#   name: 'testuser',
#   email: 'test@code.com',
#   password: 'testcode'
# )

# Label.create!(
#   title: 'Label 1'
# )

# User.create!(
#   name: 'testuser2',
#   email: 'test2@code.com',
#   password: 'testcode'
# )

# Label.create!(
#   title: 'Label 1'
# )
