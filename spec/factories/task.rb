FactoryGirl.define do
  factory :task do |user|
    name 'some long text goes here'
    description 'this is a long description text'
    user
  end
end
