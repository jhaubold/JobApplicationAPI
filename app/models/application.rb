class Application < ActiveRecord::Base
  attr_accessible :position, :text, :user_id
  #accepts_nested_attributes_for :user # funktioniert nicht, da Verhalten bei many-to-one nicht definiert
  belongs_to :user, :counter_cache => true

  validates :position, presence: true, allow_blank: false
  validates :text, presence: true, allow_blank: false
  validates :user_id, presence: true
  validate :only_three_applications, on: :create

  def only_three_applications
    if self.user.applications_count == 3
      errors.add(:base, I18n.t!(".application.attributes.application_count", scope: "activerecord.errors.models"))
    end
  end
end
