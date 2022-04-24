# == Schema Information
#
# Table name: cards
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  position    :integer
#  size        :string
#  slug        :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  person_id   :integer
#  project_id  :integer          not null
#
# Indexes
#
#  index_cards_on_person_id   (person_id)
#  index_cards_on_project_id  (project_id)
#
# Foreign Keys
#
#  person_id   (person_id => people.id)
#  project_id  (project_id => projects.id)
#
class Card < ApplicationRecord
  belongs_to :project
  belongs_to :person, optional: true
  acts_as_list scope: [:status, :project_id], sequential_updates: true

  ALPHA = %w[b c d f g h j k l m n p q r s t v w x z]
  NUMBER = %w[0 1 2 3 4 5 6 7 8 9 ! @ #]
  STATUSES = %w[archived attic unstarted started done]
  SIZES = %w[xs sm md lg xl]

  def self.generate_slug
    result = nil
    loop do
      result = "#{ALPHA.sample}#{NUMBER.sample}#{ALPHA.sample}#{NUMBER.sample}"
      break unless exists?(slug: result)
    end
    result
  end

  def self.create_from_params(card_params)
    return if card_params[:name].blank?
    result = create(card_params.except(:person))
    result.person = Person.find_by(id: card_params[:person])
    result.slug = generate_slug if result.slug.blank?
    result.save!
    result
  end

  def slugged_id(prefix = "")
    result = prefix.present? ? [prefix] : []
    result += ["card", slug]
    result.join("_")
  end

  delegate :initials, to: :safe_person
  def safe_person = person || Person.null_person

  STATUSES.each do |status_name|
    define_method "#{status_name}?" do
      status == status_name
    end
  end

  def next_status
    return "done" if done?
    STATUSES[STATUSES.index(status) + 1]
  end

  def advance
    update(status: next_status)
  end

  def previous_status
    return "archived" if archived?
    STATUSES[STATUSES.index(status) - 1]
  end

  def retreat
    update(status: previous_status)
  end
end
