class Task < ApplicationRecord
  include AASM

  aasm :column => 'state' do
    state :new, :initial => :true
    state :started, :finished

    event :start do
      transitions :from => :new, :to => :started
    end

    event :finish do
      transitions :from => :started, :to => :finished
    end
  end

  belongs_to :user
end
