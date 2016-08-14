class Task < ApplicationRecord
  include AASM
  mount_uploader :attachment, AttachmentUploader

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
  validates :name, presence: true, length: {in: 3..100}
  validates :description, presence: true, length: {in: 3..10000}

  scope :order_by_finished, -> { order('state DESC')  }
  scope :order_by_date, -> { order('created_at DESC') }
  scope :order_by_user_and_date, -> (user_id){ where(user_id: user_id).order('created_at DESC')}
end
