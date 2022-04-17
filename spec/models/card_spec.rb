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
require "rails_helper"

RSpec.describe Card, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
