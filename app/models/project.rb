# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Project < ApplicationRecord
  has_many :cards
  def clean_up_positions
    Project.transaction do
      cards.group_by(&:status).each_value do |cards|
        cards.sort_by(&:position).each_with_index do |card, index|
          card.update(position: index + 1)
        end
      end
    end
  end

  def cards_for(status)
    cards.select { _1.status == status }.sort_by(&:position)
  end
end
