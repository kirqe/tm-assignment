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

  scope :sort_by_finished, -> { order('state DESC')  }
end
