Factory.sequence(:email) { |n| "email#{n}@factory.com" }
Factory.sequence(:username) { |n| "username_#{n}" }
Factory.sequence(:title) { |n| "title_#{n}" }
Factory.sequence(:name) { |n| "name_#{n}"}

Factory.define :user do |u|
  u.email { Factory.next :email }
  u.username { Factory.next :username }
  u.first_name 'Ivan'
  u.last_name 'Pupkin'
  u.latitude '42'
  u.longitude '-71'
  u.password 'qwerty'
  u.password_confirmation 'qwerty'
end

Factory.define :admin, :class => User do |u|
  u.email { Factory.next :email }
  u.username { Factory.next :username }
  u.first_name 'Ivan'
  u.last_name 'Pupkin'
  u.latitude '42'
  u.longitude '-71'
  u.password 'qwerty'
  u.password_confirmation 'qwerty'
  u.role 'admin'
end

Factory.define :product do |p|
  p.title  { Factory.next :title }
  p.logo { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg'))  }
end

Factory.define :farm do |f|
  f.name { Factory.next :name }
  f.harvest '3'
  f.offers 'Random'
  f.address 'New York'
  f.about 'We rocks!'
  f.logo { File.new(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
end

Factory.define :farm_product do |fp|
  fp.association :farm
  fp.association :product
  fp.price { rand(100) }
  fp.harvest { rand(5) }
  fp.quantity { rand(100) }
end

Factory.define :cart do |c|
  c.association :user
end

Factory.define :cart_item do |ci|
  ci.association :cart
  ci.association :farm_product
  ci.quantity { rand(1) }
end

Factory.define :order do |o|
  o.ship_address 'Lenina st.'
  o.city 'default-city'
  o.state 'default-state'
  o.zip '66019'
  o.cc_number '44444444444444' #validate soon?
  o.telephone '66066961'
  o.association :cart
end

Factory.define :vote do |v|
  v.association :farm
  v.association :user
end