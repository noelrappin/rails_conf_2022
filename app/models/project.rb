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
  kredis_unique_list :recent_searches, limit: 5

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

  def last_search = recent_searches.to_a[-1]

  def search_complete(query)
    recent_searches.remove(last_search) if last_search && query.starts_with?(last_search)
    recent_searches << query
    Turbo::StreamsChannel.broadcast_stream_to(
      self,
      content: ApplicationController.render(
        :turbo_stream,
        partial: "projects/update_recent_searches",
        locals: {project: self}
      )
    )
  end
end
